// Temporary demo data seeder for Play Store screenshots
import 'dart:math';
import 'package:drift/drift.dart';
import 'app_database.dart';
import 'daos/symptom_entry_dao.dart';
import 'daos/trigger_dao.dart';

class DemoSeed {
  static Future<void> seed(AppDatabase db) async {
    final entryDao = db.symptomEntryDao;
    final triggerDao = db.triggerDao;

    // Check if already seeded
    final existing = await entryDao.getAllEntries();
    if (existing.isNotEmpty) return;

    final triggers = await triggerDao.getAllTriggers();
    final triggerMap = {for (final t in triggers) t.name: t.id};

    final now = DateTime.now();
    final rng = Random(42);

    // Realistic symptom patterns over 45 days
    final entries = <_DemoEntry>[
      // Today - several entries to show active tracking
      _DemoEntry('Headache', 'physical', 6, 0, 0, 45, 'Took ibuprofen', 7, 'Forehead', 'Started after long meeting', ['Stress', 'Screen time', 'Caffeine']),
      _DemoEntry('Anxiety', 'mental', 5, 0, 2, null, 'Deep breathing exercises', 6, null, 'Pre-presentation nerves', ['Work pressure', 'Caffeine']),
      _DemoEntry('Fatigue', 'physical', 4, 0, 5, 120, null, null, null, 'Afternoon slump', ['Poor sleep']),

      // Yesterday
      _DemoEntry('Back pain', 'physical', 7, 1, 9, 90, 'Stretching', 5, 'Lower back', 'Worse after sitting all day', ['Screen time']),
      _DemoEntry('Low mood', 'mental', 5, 1, 14, null, 'Went for a walk', 7, null, null, ['Poor sleep', 'Loneliness']),
      _DemoEntry('Muscle tension', 'physical', 4, 1, 18, 60, 'Hot bath', 8, 'Neck & shoulders', null, ['Stress', 'Screen time']),

      // 2 days ago
      _DemoEntry('Migraine', 'physical', 9, 2, 10, 240, 'Dark room rest + medication', 6, 'Right temple', 'Aura preceded onset', ['Poor sleep', 'Weather change', 'Stress']),
      _DemoEntry('Nausea', 'physical', 5, 2, 11, 45, 'Ginger tea', 8, null, 'Accompanied migraine', ['Skipped meal']),

      // 3 days ago
      _DemoEntry('Anxiety', 'mental', 7, 3, 8, null, 'Journaling', 5, null, 'Deadline approaching', ['Work pressure', 'Caffeine']),
      _DemoEntry('Chest tightness', 'physical', 4, 3, 15, 30, 'Breathing exercises', 7, 'Center chest', 'Related to anxiety', ['Stress']),
      _DemoEntry('Insomnia', 'mental', 6, 3, 23, null, 'Melatonin', 4, null, 'Could not fall asleep', ['Screen time', 'Caffeine']),

      // 4 days ago
      _DemoEntry('Headache', 'physical', 5, 4, 16, 60, 'Hydration + rest', 8, 'Both temples', 'Tension headache', ['Dehydration', 'Stress']),
      _DemoEntry('Brain fog', 'mental', 6, 4, 10, 180, null, null, null, 'Difficult to concentrate', ['Poor sleep']),

      // 5 days ago
      _DemoEntry('Fatigue', 'physical', 7, 5, 7, 300, 'Coffee + short nap', 5, null, 'Exhausted all day', ['Poor sleep', 'Skipped meal']),
      _DemoEntry('Irritability', 'mental', 5, 5, 13, null, null, null, null, null, ['Stress', 'Poor sleep']),
      _DemoEntry('Joint pain', 'physical', 4, 5, 17, 45, 'Anti-inflammatory gel', 6, 'Right knee', 'After exercise', ['Exercise']),

      // 6 days ago
      _DemoEntry('Stomach pain', 'physical', 6, 6, 12, 90, 'Antacid', 7, 'Upper abdomen', 'After heavy lunch', ['Skipped meal']),
      _DemoEntry('Overwhelm', 'mental', 7, 6, 9, null, 'Took a break outside', 6, null, 'Too many tasks', ['Work pressure', 'Social conflict']),

      // 7 days ago
      _DemoEntry('Headache', 'physical', 4, 7, 15, 30, 'Paracetamol', 9, 'Forehead', null, ['Screen time']),
      _DemoEntry('Anxiety', 'mental', 6, 7, 20, null, 'Meditation app', 7, null, 'Evening anxiety', ['Loneliness']),

      // 8 days ago
      _DemoEntry('Back pain', 'physical', 5, 8, 8, 120, 'Foam roller', 6, 'Upper back', null, ['Exercise']),
      _DemoEntry('Dizziness', 'physical', 3, 8, 11, 15, 'Sat down + water', 9, null, 'Brief episode', ['Dehydration']),

      // 10 days ago
      _DemoEntry('Migraine', 'physical', 8, 10, 6, 360, 'Sumatriptan', 7, 'Left temple', 'Woke up with it', ['Poor sleep', 'Weather change']),
      _DemoEntry('Nausea', 'physical', 6, 10, 7, 60, null, null, null, 'With migraine', []),
      _DemoEntry('Low mood', 'mental', 4, 10, 19, null, 'Called a friend', 8, null, null, ['Loneliness']),

      // 12 days ago
      _DemoEntry('Fatigue', 'physical', 5, 12, 9, 180, 'Early bedtime', 6, null, null, ['Alcohol']),
      _DemoEntry('Headache', 'physical', 6, 12, 10, 45, 'Ibuprofen', 8, 'Back of head', 'Hangover headache', ['Alcohol', 'Dehydration']),

      // 14 days ago
      _DemoEntry('Anxiety', 'mental', 8, 14, 7, null, 'Therapy session', 7, null, 'Work review week', ['Work pressure', 'Stress']),
      _DemoEntry('Muscle tension', 'physical', 6, 14, 16, 90, 'Massage', 9, 'Shoulders', null, ['Stress']),
      _DemoEntry('Restlessness', 'mental', 5, 14, 21, null, null, null, null, null, ['Caffeine']),

      // 16 days ago
      _DemoEntry('Headache', 'physical', 3, 16, 14, 20, null, null, 'Temples', 'Mild', ['Screen time']),
      _DemoEntry('Panic', 'mental', 8, 16, 3, 15, 'Grounding technique', 6, null, 'Woke from nightmare', ['Stress']),

      // 18 days ago
      _DemoEntry('Back pain', 'physical', 6, 18, 10, 120, 'Chiropractor visit', 7, 'Lower back', null, []),
      _DemoEntry('Fatigue', 'physical', 4, 18, 15, null, null, null, null, 'Mild afternoon fatigue', ['Skipped meal']),

      // 20 days ago
      _DemoEntry('Stomach pain', 'physical', 5, 20, 19, 60, 'Peppermint tea', 7, 'Lower abdomen', null, ['Stress']),
      _DemoEntry('Anxiety', 'mental', 5, 20, 11, null, 'Walk in nature', 8, null, null, ['Work pressure']),

      // 22 days ago
      _DemoEntry('Headache', 'physical', 7, 22, 8, 90, 'Ibuprofen + nap', 8, 'Whole head', 'Bad one', ['Poor sleep', 'Stress', 'Dehydration']),
      _DemoEntry('Irritability', 'mental', 6, 22, 13, null, null, null, null, null, ['Poor sleep']),

      // 25 days ago
      _DemoEntry('Migraine', 'physical', 9, 25, 14, 300, 'Triptan medication', 6, 'Right side', 'Visual aura', ['Weather change']),
      _DemoEntry('Nausea', 'physical', 7, 25, 15, 90, 'Anti-nausea medication', 7, null, null, []),
      _DemoEntry('Low mood', 'mental', 6, 25, 20, null, null, null, null, 'Felt down after migraine day', ['Loneliness']),

      // 28 days ago
      _DemoEntry('Brain fog', 'mental', 5, 28, 9, 240, 'Exercise', 7, null, null, ['Poor sleep', 'Screen time']),
      _DemoEntry('Fatigue', 'physical', 6, 28, 7, null, null, null, null, null, ['Poor sleep']),

      // 30 days ago
      _DemoEntry('Headache', 'physical', 4, 30, 16, 30, 'Fresh air', 8, 'Forehead', null, ['Screen time']),
      _DemoEntry('Anxiety', 'mental', 4, 30, 22, null, 'Reading', 6, null, 'Mild evening anxiety', []),

      // 33 days ago
      _DemoEntry('Joint pain', 'physical', 5, 33, 18, 60, 'Ice pack', 7, 'Left shoulder', 'After gym', ['Exercise']),
      _DemoEntry('Chest tightness', 'physical', 3, 33, 10, 20, null, null, 'Center', null, ['Caffeine']),

      // 35 days ago
      _DemoEntry('Headache', 'physical', 5, 35, 11, 45, 'Paracetamol', 7, 'Temples', null, ['Caffeine', 'Stress']),
      _DemoEntry('Overwhelm', 'mental', 6, 35, 9, null, 'Prioritized tasks', 7, null, 'Project deadline', ['Work pressure']),

      // 38 days ago
      _DemoEntry('Back pain', 'physical', 4, 38, 7, 60, 'Stretching', 8, 'Mid back', null, []),
      _DemoEntry('Insomnia', 'mental', 7, 38, 23, null, 'Sleep podcast', 5, null, null, ['Screen time', 'Caffeine']),

      // 40 days ago
      _DemoEntry('Fatigue', 'physical', 5, 40, 8, 180, null, null, null, null, ['Alcohol']),
      _DemoEntry('Dizziness', 'physical', 4, 40, 12, 10, 'Water + snack', 9, null, 'Stood up too fast', ['Dehydration', 'Skipped meal']),

      // 42 days ago
      _DemoEntry('Anxiety', 'mental', 7, 42, 16, null, 'CBD oil', 5, null, null, ['Social conflict', 'Stress']),
      _DemoEntry('Racing thoughts', 'mental', 6, 42, 22, null, 'Journaling', 7, null, 'At bedtime', ['Caffeine']),

      // 45 days ago
      _DemoEntry('Headache', 'physical', 3, 45, 14, 20, null, null, null, null, ['Weather change']),
      _DemoEntry('Muscle tension', 'physical', 5, 45, 9, 60, 'Yoga', 8, 'Neck', null, ['Stress']),
    ];

    // Insert all entries with triggers
    for (final e in entries) {
      final date = DateTime(now.year, now.month, now.day)
          .subtract(Duration(days: e.daysAgo))
          .add(Duration(hours: e.hour, minutes: rng.nextInt(50)));

      final id = await entryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: e.name,
          category: e.category,
          severity: e.severity,
          startedAt: date,
          durationMinutes: e.duration != null ? Value(e.duration!) : const Value.absent(),
          notes: e.notes != null ? Value(e.notes!) : const Value.absent(),
          reliefAction: e.relief != null ? Value(e.relief!) : const Value.absent(),
          improvedAfterAction: e.improved != null ? Value(e.improved!) : const Value.absent(),
          bodyLocation: e.bodyLocation != null ? Value(e.bodyLocation!) : const Value.absent(),
        ),
      );

      // Link triggers
      final tIds = <int>[];
      for (final tName in e.triggerNames) {
        if (triggerMap.containsKey(tName)) {
          tIds.add(triggerMap[tName]!);
        }
      }
      if (tIds.isNotEmpty) {
        await entryDao.setTriggersForEntry(id, tIds);
      }
    }
  }
}

class _DemoEntry {
  final String name;
  final String category;
  final int severity;
  final int daysAgo;
  final int hour;
  final int? duration;
  final String? relief;
  final int? improved;
  final String? bodyLocation;
  final String? notes;
  final List<String> triggerNames;

  _DemoEntry(this.name, this.category, this.severity, this.daysAgo, this.hour,
      this.duration, this.relief, this.improved, this.bodyLocation, this.notes, this.triggerNames);
}
