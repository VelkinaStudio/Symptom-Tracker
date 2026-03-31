// TODO: Google Sign-In requires Google Services configuration on Android.
// You must create a Google Cloud project, enable the Drive API, and add
// your google-services.json to android/app/ before sign-in will work.
// See: https://developers.google.com/identity/sign-in/android/start-integrating

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/providers/backup_provider.dart';
import '../../../shared/providers/database_provider.dart';

class AccountSection extends ConsumerStatefulWidget {
  const AccountSection({super.key});

  @override
  ConsumerState<AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends ConsumerState<AccountSection> {
  bool _isLoading = false;
  DateTime? _lastBackupTime;

  @override
  void initState() {
    super.initState();
    _loadLastBackupTime();
  }

  Future<void> _loadLastBackupTime() async {
    final account = ref.read(googleAccountProvider);
    if (account == null) return;
    final backupService = ref.read(driveBackupServiceProvider);
    final time = await backupService.getLastBackupTime();
    if (mounted) {
      setState(() => _lastBackupTime = time);
    }
  }

  Future<void> _signIn() async {
    setState(() => _isLoading = true);
    try {
      final googleSignIn = ref.read(googleSignInProvider);
      final account = await googleSignIn.signIn();
      if (account != null && mounted) {
        ref.read(googleAccountProvider.notifier).state = account;
        _loadLastBackupTime();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-in failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signOut() async {
    final googleSignIn = ref.read(googleSignInProvider);
    await googleSignIn.signOut();
    ref.read(googleAccountProvider.notifier).state = null;
    if (mounted) setState(() => _lastBackupTime = null);
  }

  Future<void> _backup() async {
    setState(() => _isLoading = true);
    try {
      final backupService = ref.read(driveBackupServiceProvider);
      final success = await backupService.backup(
        entryDao: ref.read(symptomEntryDaoProvider),
        triggerDao: ref.read(triggerDaoProvider),
        presetDao: ref.read(symptomPresetDaoProvider),
      );
      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Backup saved to Google Drive.')),
          );
          _loadLastBackupTime();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Backup failed. Please try again.')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Backup error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _restore() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Restore from backup?'),
        content: const Text(
          'This will import entries, triggers, and presets from your Google Drive backup. '
          'Existing local data will not be deleted — duplicates will be skipped.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Restore'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isLoading = true);
    try {
      final backupService = ref.read(driveBackupServiceProvider);
      final success = await backupService.restore(
        entryDao: ref.read(symptomEntryDaoProvider),
        triggerDao: ref.read(triggerDaoProvider),
        presetDao: ref.read(symptomPresetDaoProvider),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? 'Restore complete.'
                  : 'No backup found or restore failed.',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Restore error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final account = ref.watch(googleAccountProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account',
              style: textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (isLoggedIn && account != null) ...[
              Row(
                children: [
                  if (account.photoUrl != null)
                    CircleAvatar(
                      backgroundImage: NetworkImage(account.photoUrl!),
                      radius: 20,
                    )
                  else
                    CircleAvatar(
                      backgroundColor: colorScheme.primaryContainer,
                      radius: 20,
                      child: Icon(
                        Icons.person,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (account.displayName != null)
                          Text(
                            account.displayName!,
                            style: textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        Text(
                          account.email,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_lastBackupTime != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Last backup: ${DateFormat.yMMMd().add_jm().format(_lastBackupTime!.toLocal())}',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _backup,
                        icon: const Icon(Icons.cloud_upload_outlined),
                        label: const Text('Back up'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _restore,
                        icon: const Icon(Icons.cloud_download_outlined),
                        label: const Text('Restore'),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _isLoading ? null : _signOut,
                  child: const Text('Sign out'),
                ),
              ),
            ] else ...[
              Row(
                children: [
                  Icon(
                    Icons.cloud_off_outlined,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Sign in with Google to back up your data to Google Drive.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _isLoading ? null : _signIn,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.login),
                  label: const Text('Sign in with Google'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
