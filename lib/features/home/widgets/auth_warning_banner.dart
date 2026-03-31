import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthWarningBanner extends StatelessWidget {
  const AuthWarningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(
              Icons.cloud_off,
              color: colorScheme.onTertiaryContainer,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Your data is stored on this device only. Sign in with Google to back up your data to Google Drive.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onTertiaryContainer,
                    ),
              ),
            ),
            TextButton(
              onPressed: () => context.push('/settings'),
              child: Text(
                'Sign in',
                style: TextStyle(color: colorScheme.onTertiaryContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
