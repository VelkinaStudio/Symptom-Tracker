import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drift/drift.dart' show Value;
import '../../../shared/providers/database_provider.dart';
import '../../../shared/services/notification_service.dart';
import '../../../core/database/app_database.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/welcome_page.dart';
import '../widgets/symptom_picker_page.dart';
import '../widgets/trigger_picker_page.dart';
import '../widgets/reminder_setup_page.dart';
import '../widgets/auth_prompt_page.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _completeOnboarding() async {
    final state = ref.read(onboardingProvider);

    if (state.reminderEnabled) {
      final reminderDao = ref.read(reminderDaoProvider);
      final id = await reminderDao.insertReminder(
        RemindersCompanion.insert(
          type: 'daily',
          timeOfDay: state.reminderTime,
          label: const Value('Daily check-in'),
        ),
      );

      final parts = state.reminderTime.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      await NotificationService.requestPermissions();
      await NotificationService.scheduleDailyReminder(
        id: id,
        hour: hour,
        minute: minute,
        title: 'Symptom Tracker',
        body: 'Time to log your symptoms',
      );
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);

    if (mounted) {
      context.go('/');
    }
  }

  /// Progress value for pages 1–3 (indices 1, 2, 3).
  /// Returns null for welcome (0) and auth prompt (4).
  double? get _progressValue {
    if (_currentPage == 0 || _currentPage == 4) return null;
    return _currentPage / 3.0;
  }

  /// Show back/next buttons for pages 1–3 (not welcome, not auth prompt).
  bool get _showNavButtons => _currentPage >= 1 && _currentPage <= 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _progressValue != null
                ? LinearProgressIndicator(value: _progressValue)
                : const SizedBox(height: 4),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                children: [
                  WelcomePage(onGetStarted: _nextPage),
                  const SymptomPickerPage(),
                  const TriggerPickerPage(),
                  const ReminderSetupPage(),
                  AuthPromptPage(
                    onSignIn: _completeOnboarding,
                    onSkip: _completeOnboarding,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: _showNavButtons
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: _previousPage,
                          child: const Text('Back'),
                        ),
                        FilledButton(
                          onPressed: _nextPage,
                          child: Text(
                              _currentPage == 3 ? 'Continue' : 'Next'),
                        ),
                      ],
                    )
                  : const SizedBox(height: 48),
            ),
          ],
        ),
      ),
    );
  }
}
