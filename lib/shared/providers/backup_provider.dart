import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/drive_backup_service.dart';
import 'auth_provider.dart';

final driveBackupServiceProvider = Provider<DriveBackupService>((ref) {
  return DriveBackupService(ref.watch(googleSignInProvider));
});
