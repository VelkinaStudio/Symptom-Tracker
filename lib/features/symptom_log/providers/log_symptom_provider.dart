import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../shared/providers/database_provider.dart';
import '../../../shared/services/widget_service.dart';

class LogSymptomState {
  final String symptomName;
  final String category;
  final int severity;
  final DateTime startedAt;
  final int? durationMinutes;
  final String notes;
  final String reliefAction;
  final int? improvedAfterAction;
  final String bodyLocation;
  final Set<int> selectedTriggerIds;
  final bool isSaving;

  LogSymptomState({
    this.symptomName = '',
    this.category = 'physical',
    this.severity = 5,
    DateTime? startedAt,
    this.durationMinutes,
    this.notes = '',
    this.reliefAction = '',
    this.improvedAfterAction,
    this.bodyLocation = '',
    Set<int>? selectedTriggerIds,
    this.isSaving = false,
  })  : startedAt = startedAt ?? DateTime.now(),
        selectedTriggerIds = selectedTriggerIds ?? {};

  bool get isValid => symptomName.isNotEmpty;

  LogSymptomState copyWith({
    String? symptomName,
    String? category,
    int? severity,
    DateTime? startedAt,
    int? durationMinutes,
    bool clearDurationMinutes = false,
    String? notes,
    String? reliefAction,
    int? improvedAfterAction,
    bool clearImprovedAfterAction = false,
    String? bodyLocation,
    Set<int>? selectedTriggerIds,
    bool? isSaving,
  }) {
    return LogSymptomState(
      symptomName: symptomName ?? this.symptomName,
      category: category ?? this.category,
      severity: severity ?? this.severity,
      startedAt: startedAt ?? this.startedAt,
      durationMinutes: clearDurationMinutes
          ? null
          : (durationMinutes ?? this.durationMinutes),
      notes: notes ?? this.notes,
      reliefAction: reliefAction ?? this.reliefAction,
      improvedAfterAction: clearImprovedAfterAction
          ? null
          : (improvedAfterAction ?? this.improvedAfterAction),
      bodyLocation: bodyLocation ?? this.bodyLocation,
      selectedTriggerIds: selectedTriggerIds ?? Set<int>.from(this.selectedTriggerIds),
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class LogSymptomNotifier extends StateNotifier<LogSymptomState> {
  final Ref _ref;

  LogSymptomNotifier(this._ref)
      : super(LogSymptomState(startedAt: DateTime.now()));

  void setSymptomName(String value) =>
      state = state.copyWith(symptomName: value);

  void setCategory(String value) => state = state.copyWith(category: value);

  void setSeverity(int value) => state = state.copyWith(severity: value);

  void setStartedAt(DateTime value) =>
      state = state.copyWith(startedAt: value);

  void setDurationMinutes(int? value) {
    if (value == null) {
      state = state.copyWith(clearDurationMinutes: true);
    } else {
      state = state.copyWith(durationMinutes: value);
    }
  }

  void setNotes(String value) => state = state.copyWith(notes: value);

  void setReliefAction(String value) =>
      state = state.copyWith(reliefAction: value);

  void setImprovedAfterAction(int? value) {
    if (value == null) {
      state = state.copyWith(clearImprovedAfterAction: true);
    } else {
      state = state.copyWith(improvedAfterAction: value);
    }
  }

  void setBodyLocation(String value) =>
      state = state.copyWith(bodyLocation: value);

  void toggleTrigger(int id) {
    final current = Set<int>.from(state.selectedTriggerIds);
    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }
    state = state.copyWith(selectedTriggerIds: current);
  }

  Future<void> loadEntry(SymptomEntry entry, List<int> triggerIds) async {
    state = LogSymptomState(
      symptomName: entry.symptomName,
      category: entry.category,
      severity: entry.severity,
      startedAt: entry.startedAt,
      durationMinutes: entry.durationMinutes,
      notes: entry.notes ?? '',
      reliefAction: entry.reliefAction ?? '',
      improvedAfterAction: entry.improvedAfterAction,
      bodyLocation: entry.bodyLocation ?? '',
      selectedTriggerIds: Set<int>.from(triggerIds),
    );
  }

  Future<bool> save({int? existingEntryId}) async {
    if (!state.isValid) return false;

    state = state.copyWith(isSaving: true);
    try {
      final dao = _ref.read(symptomEntryDaoProvider);

      final durationVal = state.durationMinutes != null
          ? Value(state.durationMinutes!)
          : const Value<int?>.absent();

      final notesVal = state.notes.isNotEmpty
          ? Value(state.notes)
          : const Value<String?>.absent();

      final reliefVal = state.reliefAction.isNotEmpty
          ? Value(state.reliefAction)
          : const Value<String?>.absent();

      final improvedVal = state.improvedAfterAction != null
          ? Value(state.improvedAfterAction!)
          : const Value<int?>.absent();

      final bodyLocVal = state.bodyLocation.isNotEmpty
          ? Value(state.bodyLocation)
          : const Value<String?>.absent();

      int entryId;

      if (existingEntryId != null) {
        final companion = SymptomEntriesCompanion(
          id: Value(existingEntryId),
          symptomName: Value(state.symptomName),
          category: Value(state.category),
          severity: Value(state.severity),
          startedAt: Value(state.startedAt),
          durationMinutes: durationVal,
          notes: notesVal,
          reliefAction: reliefVal,
          improvedAfterAction: improvedVal,
          bodyLocation: bodyLocVal,
        );
        await dao.updateEntry(companion);
        entryId = existingEntryId;
      } else {
        final companion = SymptomEntriesCompanion.insert(
          symptomName: state.symptomName,
          category: state.category,
          severity: state.severity,
          startedAt: state.startedAt,
          durationMinutes: durationVal,
          notes: notesVal,
          reliefAction: reliefVal,
          improvedAfterAction: improvedVal,
          bodyLocation: bodyLocVal,
        );
        entryId = await dao.insertEntry(companion);
      }

      await dao.setTriggersForEntry(
          entryId, state.selectedTriggerIds.toList());

      // Update home screen widget with fresh data
      final todayCount = await dao.countEntriesForDate(DateTime.now());
      final topSymptoms = await WidgetService.computeTopSymptoms(dao);
      await WidgetService.updateWidgetData(
        todayCount: todayCount,
        topSymptoms: topSymptoms,
      );

      return true;
    } catch (_) {
      return false;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}

final logSymptomProvider =
    StateNotifierProvider.autoDispose<LogSymptomNotifier, LogSymptomState>(
  (ref) => LogSymptomNotifier(ref),
);
