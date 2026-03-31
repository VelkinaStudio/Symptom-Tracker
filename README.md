# Symptom Tracker

A Flutter app for logging daily symptoms, spotting patterns, and generating reports to share with your doctor.

## Features

- **Symptom Logging** - Record symptoms with severity, duration, body location, triggers, and notes
- **Calendar History** - Browse past entries on a monthly calendar view
- **Trends & Charts** - Visualize symptom frequency and severity over time
- **PDF Reports** - Generate and share/download reports for appointments
- **Google Drive Backup** - Back up and restore your data via Google Drive
- **Home Widget** - Quick-log symptoms directly from your home screen
- **Notifications** - Configurable reminders to log symptoms

## Tech Stack

- **Flutter** (Dart SDK ^3.7.0)
- **State Management** - Riverpod
- **Database** - Drift (SQLite)
- **Routing** - GoRouter
- **Charts** - fl_chart
- **PDF** - pdf + printing

## Getting Started

### Prerequisites

- Flutter SDK ^3.7.0
- Android SDK (for Android builds)
- Xcode (for iOS builds)

### Setup

```bash
# Clone the repo
git clone https://github.com/VelkinaStudio/Symptom-Tracker.git
cd Symptom-Tracker

# Install dependencies
flutter pub get

# Run code generation (Drift + Riverpod)
dart run build_runner build --delete-conflicting-outputs

# Run on a connected device
flutter run
```

## Project Structure

```
lib/
  core/          # Database, router, utilities
  features/      # Feature modules
    home/        # Home screen & dashboard
    history/     # Calendar-based history view
    symptom_log/ # Symptom entry form
    trends/      # Charts & analytics
    reports/     # PDF report generation
    settings/    # App settings & backup
    onboarding/  # First-run onboarding
  shared/        # Shared widgets, providers, services
```

## Privacy

Symptom Tracker does not collect, store, or transmit any user data to external servers. All health data remains on your device. Optional Google Drive backup stores a file in your own Google Drive account.

See [PRIVACY_POLICY.md](PRIVACY_POLICY.md) for details.

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.
