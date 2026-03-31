import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingState {
  final Set<int> selectedPresetIds;
  final Set<int> selectedTriggerIds;
  final bool reminderEnabled;
  final String reminderTime;

  const OnboardingState({
    this.selectedPresetIds = const {},
    this.selectedTriggerIds = const {},
    this.reminderEnabled = true,
    this.reminderTime = '20:00',
  });

  OnboardingState copyWith({
    Set<int>? selectedPresetIds,
    Set<int>? selectedTriggerIds,
    bool? reminderEnabled,
    String? reminderTime,
  }) {
    return OnboardingState(
      selectedPresetIds: selectedPresetIds ?? this.selectedPresetIds,
      selectedTriggerIds: selectedTriggerIds ?? this.selectedTriggerIds,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderTime: reminderTime ?? this.reminderTime,
    );
  }
}

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier() : super(const OnboardingState());

  void togglePreset(int id) {
    final updated = Set<int>.from(state.selectedPresetIds);
    if (updated.contains(id)) {
      updated.remove(id);
    } else {
      updated.add(id);
    }
    state = state.copyWith(selectedPresetIds: updated);
  }

  void toggleTrigger(int id) {
    final updated = Set<int>.from(state.selectedTriggerIds);
    if (updated.contains(id)) {
      updated.remove(id);
    } else {
      updated.add(id);
    }
    state = state.copyWith(selectedTriggerIds: updated);
  }

  void setReminderEnabled(bool enabled) =>
      state = state.copyWith(reminderEnabled: enabled);

  void setReminderTime(String time) =>
      state = state.copyWith(reminderTime: time);
}

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier();
});
