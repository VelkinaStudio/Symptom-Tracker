// lib/core/database/seed_data.dart

class SeedData {
  static const List<Map<String, String>> defaultTriggers = [
    {'name': 'Poor sleep', 'category': 'lifestyle'},
    {'name': 'Stress', 'category': 'mental'},
    {'name': 'Skipped meal', 'category': 'lifestyle'},
    {'name': 'Caffeine', 'category': 'lifestyle'},
    {'name': 'Alcohol', 'category': 'lifestyle'},
    {'name': 'Dehydration', 'category': 'lifestyle'},
    {'name': 'Weather change', 'category': 'lifestyle'},
    {'name': 'Exercise', 'category': 'lifestyle'},
    {'name': 'Screen time', 'category': 'lifestyle'},
    {'name': 'Social conflict', 'category': 'mental'},
    {'name': 'Loneliness', 'category': 'mental'},
    {'name': 'Work pressure', 'category': 'mental'},
  ];

  static const List<Map<String, String>> defaultSymptomPresets = [
    // Physical
    {'name': 'Headache', 'category': 'physical'},
    {'name': 'Migraine', 'category': 'physical'},
    {'name': 'Nausea', 'category': 'physical'},
    {'name': 'Fatigue', 'category': 'physical'},
    {'name': 'Back pain', 'category': 'physical'},
    {'name': 'Joint pain', 'category': 'physical'},
    {'name': 'Stomach pain', 'category': 'physical'},
    {'name': 'Dizziness', 'category': 'physical'},
    {'name': 'Chest tightness', 'category': 'physical'},
    {'name': 'Muscle tension', 'category': 'physical'},
    // Mental
    {'name': 'Anxiety', 'category': 'mental'},
    {'name': 'Low mood', 'category': 'mental'},
    {'name': 'Irritability', 'category': 'mental'},
    {'name': 'Brain fog', 'category': 'mental'},
    {'name': 'Panic', 'category': 'mental'},
    {'name': 'Insomnia', 'category': 'mental'},
    {'name': 'Restlessness', 'category': 'mental'},
    {'name': 'Overwhelm', 'category': 'mental'},
    {'name': 'Apathy', 'category': 'mental'},
    {'name': 'Racing thoughts', 'category': 'mental'},
  ];
}
