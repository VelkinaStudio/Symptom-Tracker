// lib/core/database/daos/sync_meta_dao.dart
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/sync_meta.dart';

part 'sync_meta_dao.g.dart';

@DriftAccessor(tables: [SyncMeta])
class SyncMetaDao extends DatabaseAccessor<AppDatabase>
    with _$SyncMetaDaoMixin {
  SyncMetaDao(super.db);

  Future<String?> getValue(String key) async {
    final row = await (select(syncMeta)
          ..where((s) => s.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> setValue(String key, String value) =>
      into(syncMeta).insertOnConflictUpdate(
        SyncMetaCompanion.insert(key: key, value: value),
      );
}
