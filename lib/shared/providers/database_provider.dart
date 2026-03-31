import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/app_database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final symptomEntryDaoProvider = Provider((ref) {
  return ref.watch(databaseProvider).symptomEntryDao;
});

final triggerDaoProvider = Provider((ref) {
  return ref.watch(databaseProvider).triggerDao;
});

final symptomPresetDaoProvider = Provider((ref) {
  return ref.watch(databaseProvider).symptomPresetDao;
});

final reminderDaoProvider = Provider((ref) {
  return ref.watch(databaseProvider).reminderDao;
});

final syncMetaDaoProvider = Provider((ref) {
  return ref.watch(databaseProvider).syncMetaDao;
});
