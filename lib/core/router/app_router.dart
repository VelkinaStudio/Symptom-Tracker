import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/widgets/bottom_nav_shell.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/history/screens/history_screen.dart';
import '../../features/trends/screens/trends_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/symptom_log/screens/log_symptom_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/reports/screens/reports_screen.dart';
import '../../main.dart' show onboardingComplete;

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: onboardingComplete ? '/' : '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BottomNavShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: '/history',
                builder: (context, state) => const HistoryScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: '/trends',
                builder: (context, state) => const TrendsScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen()),
          ]),
        ],
      ),
      GoRoute(
          path: '/log',
          builder: (context, state) {
            final symptom = state.uri.queryParameters['symptom'];
            final dateStr = state.uri.queryParameters['date'];
            final date = dateStr != null ? DateTime.tryParse(dateStr) : null;
            return LogSymptomScreen(initialSymptom: symptom, initialDate: date);
          }),
      GoRoute(
        path: '/log/:entryId',
        builder: (context, state) {
          final entryId = int.parse(state.pathParameters['entryId']!);
          return LogSymptomScreen(editEntryId: entryId);
        },
      ),
      GoRoute(
          path: '/reports',
          builder: (context, state) => const ReportsScreen()),
    ],
  );
});
