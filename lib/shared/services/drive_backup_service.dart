import 'dart:convert';
import 'package:drift/drift.dart' hide Column;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import '../../core/database/app_database.dart';
import '../../core/database/daos/symptom_entry_dao.dart';
import '../../core/database/daos/trigger_dao.dart';
import '../../core/database/daos/symptom_preset_dao.dart';

class DriveBackupService {
  static const _backupFileName = 'symptom_tracker_backup.json';

  final GoogleSignIn _googleSignIn;

  DriveBackupService(this._googleSignIn);

  Future<drive.DriveApi?> _getDriveApi() async {
    final httpClient = await _googleSignIn.authenticatedClient();
    if (httpClient == null) return null;
    return drive.DriveApi(httpClient);
  }

  /// Back up all data to Google Drive appdata folder.
  Future<bool> backup({
    required SymptomEntryDao entryDao,
    required TriggerDao triggerDao,
    required SymptomPresetDao presetDao,
  }) async {
    final driveApi = await _getDriveApi();
    if (driveApi == null) return false;

    // Gather all data
    final entries = await entryDao.getAllEntries();
    final triggers = await triggerDao.getAllTriggers();
    final presets = await presetDao.getAllPresets();

    final backupData = {
      'version': 1,
      'exported_at': DateTime.now().toIso8601String(),
      'entries': entries
          .map((e) => {
                'symptomName': e.symptomName,
                'category': e.category,
                'severity': e.severity,
                'startedAt': e.startedAt.toIso8601String(),
                'durationMinutes': e.durationMinutes,
                'notes': e.notes,
                'reliefAction': e.reliefAction,
                'improvedAfterAction': e.improvedAfterAction,
                'bodyLocation': e.bodyLocation,
                'createdAt': e.createdAt.toIso8601String(),
              })
          .toList(),
      'triggers': triggers
          .where((t) => !t.isDefault)
          .map((t) => {
                'name': t.name,
                'category': t.category,
              })
          .toList(),
      'presets': presets
          .where((p) => !p.isDefault)
          .map((p) => {
                'name': p.name,
                'category': p.category,
              })
          .toList(),
    };

    final jsonString = const JsonEncoder.withIndent('  ').convert(backupData);
    final bytes = utf8.encode(jsonString);

    // Check if backup file already exists
    final existingFileId = await _findBackupFileId(driveApi);

    final media = drive.Media(
      Stream.fromIterable([bytes]),
      bytes.length,
      contentType: 'application/json',
    );

    if (existingFileId != null) {
      // Update existing file
      await driveApi.files.update(
        drive.File(),
        existingFileId,
        uploadMedia: media,
      );
    } else {
      // Create new file in appdata
      final driveFile = drive.File()
        ..name = _backupFileName
        ..parents = ['appDataFolder'];
      await driveApi.files.create(
        driveFile,
        uploadMedia: media,
      );
    }

    return true;
  }

  /// Fetch raw backup data from Google Drive.
  Future<Map<String, dynamic>?> getBackupData() async {
    final driveApi = await _getDriveApi();
    if (driveApi == null) return null;

    final fileId = await _findBackupFileId(driveApi);
    if (fileId == null) return null;

    final response = await driveApi.files.get(
      fileId,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;

    final bytes = <int>[];
    await for (final chunk in response.stream) {
      bytes.addAll(chunk);
    }

    final jsonString = utf8.decode(bytes);
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  /// Restore backup data into the local database.
  Future<bool> restore({
    required SymptomEntryDao entryDao,
    required TriggerDao triggerDao,
    required SymptomPresetDao presetDao,
  }) async {
    final data = await getBackupData();
    if (data == null) return false;

    // Import entries
    final entries = data['entries'] as List? ?? [];
    for (final entry in entries) {
      await entryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: entry['symptomName'] as String,
          category: entry['category'] as String,
          severity: entry['severity'] as int,
          startedAt: DateTime.parse(entry['startedAt'] as String),
          durationMinutes: Value(entry['durationMinutes'] as int?),
          notes: Value(entry['notes'] as String?),
          reliefAction: Value(entry['reliefAction'] as String?),
          improvedAfterAction: Value(entry['improvedAfterAction'] as int?),
          bodyLocation: Value(entry['bodyLocation'] as String?),
        ),
      );
    }

    // Import custom triggers
    final triggers = data['triggers'] as List? ?? [];
    for (final trigger in triggers) {
      try {
        await triggerDao.insertTrigger(
          TriggersCompanion.insert(
            name: trigger['name'] as String,
            category: trigger['category'] as String,
          ),
        );
      } catch (_) {
        // Skip duplicates
      }
    }

    // Import custom presets
    final presets = data['presets'] as List? ?? [];
    for (final preset in presets) {
      try {
        await presetDao.insertPreset(
          SymptomPresetsCompanion.insert(
            name: preset['name'] as String,
            category: preset['category'] as String,
          ),
        );
      } catch (_) {
        // Skip duplicates
      }
    }

    return true;
  }

  /// Returns the last modified time of the backup file, or null if none exists.
  Future<DateTime?> getLastBackupTime() async {
    final driveApi = await _getDriveApi();
    if (driveApi == null) return null;

    final fileId = await _findBackupFileId(driveApi);
    if (fileId == null) return null;

    final file = await driveApi.files.get(
      fileId,
      $fields: 'modifiedTime',
    ) as drive.File;

    return file.modifiedTime;
  }

  Future<String?> _findBackupFileId(drive.DriveApi driveApi) async {
    final fileList = await driveApi.files.list(
      spaces: 'appDataFolder',
      q: "name = '$_backupFileName'",
      $fields: 'files(id)',
    );

    if (fileList.files != null && fileList.files!.isNotEmpty) {
      return fileList.files!.first.id;
    }
    return null;
  }
}
