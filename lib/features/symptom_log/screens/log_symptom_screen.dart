import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/providers/database_provider.dart';
import '../providers/log_symptom_provider.dart';
import '../widgets/severity_slider.dart';
import '../widgets/symptom_search_field.dart';
import '../widgets/duration_picker.dart';
import '../widgets/trigger_selector.dart';
import '../widgets/relief_action_field.dart';

class LogSymptomScreen extends ConsumerStatefulWidget {
  final int? editEntryId;
  final String? initialSymptom;
  final DateTime? initialDate;

  const LogSymptomScreen({super.key, this.editEntryId, this.initialSymptom, this.initialDate});

  @override
  ConsumerState<LogSymptomScreen> createState() => _LogSymptomScreenState();
}

class _LogSymptomScreenState extends ConsumerState<LogSymptomScreen> {
  late final TextEditingController _bodyLocationController;
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _bodyLocationController = TextEditingController();
    _notesController = TextEditingController();

    if (widget.editEntryId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _loadExistingEntry();
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.initialSymptom != null && widget.initialSymptom!.isNotEmpty) {
          ref.read(logSymptomProvider.notifier).setSymptomName(widget.initialSymptom!);
        }
        if (widget.initialDate != null) {
          ref.read(logSymptomProvider.notifier).setStartedAt(widget.initialDate!);
        }
      });
    }
  }

  Future<void> _loadExistingEntry() async {
    final dao = ref.read(symptomEntryDaoProvider);
    final entries = await dao.getAllEntries();
    final entry = entries.where((e) => e.id == widget.editEntryId).firstOrNull;
    if (entry != null) {
      final triggerIds = await dao.getTriggerIdsForEntry(entry.id);
      await ref
          .read(logSymptomProvider.notifier)
          .loadEntry(entry, triggerIds);
      final state = ref.read(logSymptomProvider);
      _bodyLocationController.text = state.bodyLocation;
      _notesController.text = state.notes;
    }
  }

  @override
  void dispose() {
    _bodyLocationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final success = await ref
        .read(logSymptomProvider.notifier)
        .save(existingEntryId: widget.editEntryId);
    if (success && mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(logSymptomProvider);
    final notifier = ref.read(logSymptomProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.editEntryId != null ? 'Edit Symptom' : 'Log Symptom'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Symptom search field
            const SymptomSearchField(),
            const SizedBox(height: 16),

            // 2. Severity slider
            SeveritySlider(
              value: state.severity,
              onChanged: notifier.setSeverity,
            ),
            const SizedBox(height: 16),

            // 3. Date and time pickers
            _DateTimePicker(
              value: state.startedAt,
              onChanged: notifier.setStartedAt,
            ),
            const SizedBox(height: 16),

            // 4. Duration picker
            DurationPicker(
              value: state.durationMinutes,
              onChanged: notifier.setDurationMinutes,
            ),
            const SizedBox(height: 16),

            // 5. Trigger selector
            TriggerSelector(
              selectedIds: state.selectedTriggerIds,
              onToggle: notifier.toggleTrigger,
            ),
            const SizedBox(height: 16),

            // 6. Relief action field
            ReliefActionField(
              value: state.reliefAction,
              improvedAfterAction: state.improvedAfterAction,
              onChanged: notifier.setReliefAction,
              onImprovedChanged: notifier.setImprovedAfterAction,
            ),
            const SizedBox(height: 16),

            // 7. Body location
            TextField(
              controller: _bodyLocationController,
              decoration: const InputDecoration(
                labelText: 'Body location',
                border: OutlineInputBorder(),
              ),
              onChanged: notifier.setBodyLocation,
            ),
            const SizedBox(height: 16),

            // 8. Notes
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              onChanged: notifier.setNotes,
            ),
            const SizedBox(height: 24),

            // 9. Save button
            FilledButton(
              onPressed:
                  (state.isValid && !state.isSaving) ? _save : null,
              child: state.isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateTimePicker extends StatelessWidget {
  final DateTime value;
  final ValueChanged<DateTime> onChanged;

  const _DateTimePicker({
    required this.value,
    required this.onChanged,
  });

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: value,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) {
      onChanged(DateTime(
        picked.year,
        picked.month,
        picked.day,
        value.hour,
        value.minute,
      ));
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(value),
    );
    if (picked != null) {
      onChanged(DateTime(
        value.year,
        value.month,
        value.day,
        picked.hour,
        picked.minute,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateStr =
        '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
    final timeStr =
        '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';

    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _pickDate(context),
            icon: const Icon(Icons.calendar_today, size: 16),
            label: Text(dateStr),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _pickTime(context),
            icon: const Icon(Icons.access_time, size: 16),
            label: Text(timeStr),
          ),
        ),
      ],
    );
  }
}
