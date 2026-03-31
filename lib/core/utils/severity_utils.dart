// lib/core/utils/severity_utils.dart
import 'package:flutter/material.dart';

class SeverityUtils {
  static String label(int severity) {
    if (severity <= 3) return 'Mild';
    if (severity <= 6) return 'Moderate';
    return 'Severe';
  }

  static Color color(int severity) {
    if (severity <= 3) return const Color(0xFF4CAF50);
    if (severity <= 6) return const Color(0xFFFFC107);
    return const Color(0xFFF44336);
  }

  static Color backgroundColor(int severity) {
    return color(severity).withValues(alpha: 0.15);
  }
}
