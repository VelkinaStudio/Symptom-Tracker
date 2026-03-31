import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:symptom_tracker/features/symptom_log/widgets/severity_slider.dart';

void main() {
  group('SeveritySlider', () {
    testWidgets('displays current value and label', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: SeveritySlider(value: 3, onChanged: (_) {}))));
      expect(find.text('3 — Mild'), findsOneWidget);
    });
    testWidgets('shows Moderate for severity 5', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: SeveritySlider(value: 5, onChanged: (_) {}))));
      expect(find.text('5 — Moderate'), findsOneWidget);
    });
    testWidgets('shows Severe for severity 8', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: SeveritySlider(value: 8, onChanged: (_) {}))));
      expect(find.text('8 — Severe'), findsOneWidget);
    });
  });
}
