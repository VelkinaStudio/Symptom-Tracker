import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'shared/services/notification_service.dart';
import 'shared/services/widget_service.dart';

/// Loaded once at startup so the router redirect is synchronous.
late final bool onboardingComplete;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  onboardingComplete = prefs.getBool('onboarding_complete') ?? false;
  await NotificationService.initialize();
  await WidgetService.initialize();
  runApp(
    const ProviderScope(
      child: SymptomTrackerApp(),
    ),
  );
}
