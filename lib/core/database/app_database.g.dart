// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SymptomEntriesTable extends SymptomEntries
    with TableInfo<$SymptomEntriesTable, SymptomEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _symptomNameMeta = const VerificationMeta(
    'symptomName',
  );
  @override
  late final GeneratedColumn<String> symptomName = GeneratedColumn<String>(
    'symptom_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _severityMeta = const VerificationMeta(
    'severity',
  );
  @override
  late final GeneratedColumn<int> severity = GeneratedColumn<int>(
    'severity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (severity BETWEEN 1 AND 10)',
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reliefActionMeta = const VerificationMeta(
    'reliefAction',
  );
  @override
  late final GeneratedColumn<String> reliefAction = GeneratedColumn<String>(
    'relief_action',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _improvedAfterActionMeta =
      const VerificationMeta('improvedAfterAction');
  @override
  late final GeneratedColumn<int> improvedAfterAction = GeneratedColumn<int>(
    'improved_after_action',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyLocationMeta = const VerificationMeta(
    'bodyLocation',
  );
  @override
  late final GeneratedColumn<String> bodyLocation = GeneratedColumn<String>(
    'body_location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    symptomName,
    category,
    severity,
    startedAt,
    durationMinutes,
    notes,
    reliefAction,
    improvedAfterAction,
    bodyLocation,
    createdAt,
    updatedAt,
    syncedAt,
    deleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptom_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<SymptomEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('symptom_name')) {
      context.handle(
        _symptomNameMeta,
        symptomName.isAcceptableOrUnknown(
          data['symptom_name']!,
          _symptomNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_symptomNameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(
        _severityMeta,
        severity.isAcceptableOrUnknown(data['severity']!, _severityMeta),
      );
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('relief_action')) {
      context.handle(
        _reliefActionMeta,
        reliefAction.isAcceptableOrUnknown(
          data['relief_action']!,
          _reliefActionMeta,
        ),
      );
    }
    if (data.containsKey('improved_after_action')) {
      context.handle(
        _improvedAfterActionMeta,
        improvedAfterAction.isAcceptableOrUnknown(
          data['improved_after_action']!,
          _improvedAfterActionMeta,
        ),
      );
    }
    if (data.containsKey('body_location')) {
      context.handle(
        _bodyLocationMeta,
        bodyLocation.isAcceptableOrUnknown(
          data['body_location']!,
          _bodyLocationMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SymptomEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SymptomEntry(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      symptomName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}symptom_name'],
          )!,
      category:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category'],
          )!,
      severity:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}severity'],
          )!,
      startedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}started_at'],
          )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      reliefAction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relief_action'],
      ),
      improvedAfterAction: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}improved_after_action'],
      ),
      bodyLocation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_location'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
      deleted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}deleted'],
          )!,
    );
  }

  @override
  $SymptomEntriesTable createAlias(String alias) {
    return $SymptomEntriesTable(attachedDatabase, alias);
  }
}

class SymptomEntry extends DataClass implements Insertable<SymptomEntry> {
  final int id;
  final String? remoteId;
  final String symptomName;
  final String category;
  final int severity;
  final DateTime startedAt;
  final int? durationMinutes;
  final String? notes;
  final String? reliefAction;
  final int? improvedAfterAction;
  final String? bodyLocation;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? syncedAt;
  final bool deleted;
  const SymptomEntry({
    required this.id,
    this.remoteId,
    required this.symptomName,
    required this.category,
    required this.severity,
    required this.startedAt,
    this.durationMinutes,
    this.notes,
    this.reliefAction,
    this.improvedAfterAction,
    this.bodyLocation,
    required this.createdAt,
    required this.updatedAt,
    this.syncedAt,
    required this.deleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['symptom_name'] = Variable<String>(symptomName);
    map['category'] = Variable<String>(category);
    map['severity'] = Variable<int>(severity);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || durationMinutes != null) {
      map['duration_minutes'] = Variable<int>(durationMinutes);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || reliefAction != null) {
      map['relief_action'] = Variable<String>(reliefAction);
    }
    if (!nullToAbsent || improvedAfterAction != null) {
      map['improved_after_action'] = Variable<int>(improvedAfterAction);
    }
    if (!nullToAbsent || bodyLocation != null) {
      map['body_location'] = Variable<String>(bodyLocation);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    map['deleted'] = Variable<bool>(deleted);
    return map;
  }

  SymptomEntriesCompanion toCompanion(bool nullToAbsent) {
    return SymptomEntriesCompanion(
      id: Value(id),
      remoteId:
          remoteId == null && nullToAbsent
              ? const Value.absent()
              : Value(remoteId),
      symptomName: Value(symptomName),
      category: Value(category),
      severity: Value(severity),
      startedAt: Value(startedAt),
      durationMinutes:
          durationMinutes == null && nullToAbsent
              ? const Value.absent()
              : Value(durationMinutes),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      reliefAction:
          reliefAction == null && nullToAbsent
              ? const Value.absent()
              : Value(reliefAction),
      improvedAfterAction:
          improvedAfterAction == null && nullToAbsent
              ? const Value.absent()
              : Value(improvedAfterAction),
      bodyLocation:
          bodyLocation == null && nullToAbsent
              ? const Value.absent()
              : Value(bodyLocation),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncedAt:
          syncedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(syncedAt),
      deleted: Value(deleted),
    );
  }

  factory SymptomEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SymptomEntry(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      symptomName: serializer.fromJson<String>(json['symptomName']),
      category: serializer.fromJson<String>(json['category']),
      severity: serializer.fromJson<int>(json['severity']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      durationMinutes: serializer.fromJson<int?>(json['durationMinutes']),
      notes: serializer.fromJson<String?>(json['notes']),
      reliefAction: serializer.fromJson<String?>(json['reliefAction']),
      improvedAfterAction: serializer.fromJson<int?>(
        json['improvedAfterAction'],
      ),
      bodyLocation: serializer.fromJson<String?>(json['bodyLocation']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<String?>(remoteId),
      'symptomName': serializer.toJson<String>(symptomName),
      'category': serializer.toJson<String>(category),
      'severity': serializer.toJson<int>(severity),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'durationMinutes': serializer.toJson<int?>(durationMinutes),
      'notes': serializer.toJson<String?>(notes),
      'reliefAction': serializer.toJson<String?>(reliefAction),
      'improvedAfterAction': serializer.toJson<int?>(improvedAfterAction),
      'bodyLocation': serializer.toJson<String?>(bodyLocation),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'deleted': serializer.toJson<bool>(deleted),
    };
  }

  SymptomEntry copyWith({
    int? id,
    Value<String?> remoteId = const Value.absent(),
    String? symptomName,
    String? category,
    int? severity,
    DateTime? startedAt,
    Value<int?> durationMinutes = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> reliefAction = const Value.absent(),
    Value<int?> improvedAfterAction = const Value.absent(),
    Value<String?> bodyLocation = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> syncedAt = const Value.absent(),
    bool? deleted,
  }) => SymptomEntry(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    symptomName: symptomName ?? this.symptomName,
    category: category ?? this.category,
    severity: severity ?? this.severity,
    startedAt: startedAt ?? this.startedAt,
    durationMinutes:
        durationMinutes.present ? durationMinutes.value : this.durationMinutes,
    notes: notes.present ? notes.value : this.notes,
    reliefAction: reliefAction.present ? reliefAction.value : this.reliefAction,
    improvedAfterAction:
        improvedAfterAction.present
            ? improvedAfterAction.value
            : this.improvedAfterAction,
    bodyLocation: bodyLocation.present ? bodyLocation.value : this.bodyLocation,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
    deleted: deleted ?? this.deleted,
  );
  SymptomEntry copyWithCompanion(SymptomEntriesCompanion data) {
    return SymptomEntry(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      symptomName:
          data.symptomName.present ? data.symptomName.value : this.symptomName,
      category: data.category.present ? data.category.value : this.category,
      severity: data.severity.present ? data.severity.value : this.severity,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      durationMinutes:
          data.durationMinutes.present
              ? data.durationMinutes.value
              : this.durationMinutes,
      notes: data.notes.present ? data.notes.value : this.notes,
      reliefAction:
          data.reliefAction.present
              ? data.reliefAction.value
              : this.reliefAction,
      improvedAfterAction:
          data.improvedAfterAction.present
              ? data.improvedAfterAction.value
              : this.improvedAfterAction,
      bodyLocation:
          data.bodyLocation.present
              ? data.bodyLocation.value
              : this.bodyLocation,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SymptomEntry(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('symptomName: $symptomName, ')
          ..write('category: $category, ')
          ..write('severity: $severity, ')
          ..write('startedAt: $startedAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('notes: $notes, ')
          ..write('reliefAction: $reliefAction, ')
          ..write('improvedAfterAction: $improvedAfterAction, ')
          ..write('bodyLocation: $bodyLocation, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    symptomName,
    category,
    severity,
    startedAt,
    durationMinutes,
    notes,
    reliefAction,
    improvedAfterAction,
    bodyLocation,
    createdAt,
    updatedAt,
    syncedAt,
    deleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymptomEntry &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.symptomName == this.symptomName &&
          other.category == this.category &&
          other.severity == this.severity &&
          other.startedAt == this.startedAt &&
          other.durationMinutes == this.durationMinutes &&
          other.notes == this.notes &&
          other.reliefAction == this.reliefAction &&
          other.improvedAfterAction == this.improvedAfterAction &&
          other.bodyLocation == this.bodyLocation &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncedAt == this.syncedAt &&
          other.deleted == this.deleted);
}

class SymptomEntriesCompanion extends UpdateCompanion<SymptomEntry> {
  final Value<int> id;
  final Value<String?> remoteId;
  final Value<String> symptomName;
  final Value<String> category;
  final Value<int> severity;
  final Value<DateTime> startedAt;
  final Value<int?> durationMinutes;
  final Value<String?> notes;
  final Value<String?> reliefAction;
  final Value<int?> improvedAfterAction;
  final Value<String?> bodyLocation;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> syncedAt;
  final Value<bool> deleted;
  const SymptomEntriesCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.symptomName = const Value.absent(),
    this.category = const Value.absent(),
    this.severity = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.reliefAction = const Value.absent(),
    this.improvedAfterAction = const Value.absent(),
    this.bodyLocation = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.deleted = const Value.absent(),
  });
  SymptomEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    required String symptomName,
    required String category,
    required int severity,
    required DateTime startedAt,
    this.durationMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.reliefAction = const Value.absent(),
    this.improvedAfterAction = const Value.absent(),
    this.bodyLocation = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.deleted = const Value.absent(),
  }) : symptomName = Value(symptomName),
       category = Value(category),
       severity = Value(severity),
       startedAt = Value(startedAt);
  static Insertable<SymptomEntry> custom({
    Expression<int>? id,
    Expression<String>? remoteId,
    Expression<String>? symptomName,
    Expression<String>? category,
    Expression<int>? severity,
    Expression<DateTime>? startedAt,
    Expression<int>? durationMinutes,
    Expression<String>? notes,
    Expression<String>? reliefAction,
    Expression<int>? improvedAfterAction,
    Expression<String>? bodyLocation,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? syncedAt,
    Expression<bool>? deleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (symptomName != null) 'symptom_name': symptomName,
      if (category != null) 'category': category,
      if (severity != null) 'severity': severity,
      if (startedAt != null) 'started_at': startedAt,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (notes != null) 'notes': notes,
      if (reliefAction != null) 'relief_action': reliefAction,
      if (improvedAfterAction != null)
        'improved_after_action': improvedAfterAction,
      if (bodyLocation != null) 'body_location': bodyLocation,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (deleted != null) 'deleted': deleted,
    });
  }

  SymptomEntriesCompanion copyWith({
    Value<int>? id,
    Value<String?>? remoteId,
    Value<String>? symptomName,
    Value<String>? category,
    Value<int>? severity,
    Value<DateTime>? startedAt,
    Value<int?>? durationMinutes,
    Value<String?>? notes,
    Value<String?>? reliefAction,
    Value<int?>? improvedAfterAction,
    Value<String?>? bodyLocation,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? syncedAt,
    Value<bool>? deleted,
  }) {
    return SymptomEntriesCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      symptomName: symptomName ?? this.symptomName,
      category: category ?? this.category,
      severity: severity ?? this.severity,
      startedAt: startedAt ?? this.startedAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      notes: notes ?? this.notes,
      reliefAction: reliefAction ?? this.reliefAction,
      improvedAfterAction: improvedAfterAction ?? this.improvedAfterAction,
      bodyLocation: bodyLocation ?? this.bodyLocation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      deleted: deleted ?? this.deleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (symptomName.present) {
      map['symptom_name'] = Variable<String>(symptomName.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (severity.present) {
      map['severity'] = Variable<int>(severity.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (reliefAction.present) {
      map['relief_action'] = Variable<String>(reliefAction.value);
    }
    if (improvedAfterAction.present) {
      map['improved_after_action'] = Variable<int>(improvedAfterAction.value);
    }
    if (bodyLocation.present) {
      map['body_location'] = Variable<String>(bodyLocation.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomEntriesCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('symptomName: $symptomName, ')
          ..write('category: $category, ')
          ..write('severity: $severity, ')
          ..write('startedAt: $startedAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('notes: $notes, ')
          ..write('reliefAction: $reliefAction, ')
          ..write('improvedAfterAction: $improvedAfterAction, ')
          ..write('bodyLocation: $bodyLocation, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }
}

class $TriggersTable extends Triggers
    with TableInfo<$TriggersTable, TriggerEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TriggersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, category, isDefault];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'triggers';
  @override
  VerificationContext validateIntegrity(
    Insertable<TriggerEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TriggerEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TriggerEntry(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      category:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category'],
          )!,
      isDefault:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_default'],
          )!,
    );
  }

  @override
  $TriggersTable createAlias(String alias) {
    return $TriggersTable(attachedDatabase, alias);
  }
}

class TriggerEntry extends DataClass implements Insertable<TriggerEntry> {
  final int id;
  final String name;
  final String category;
  final bool isDefault;
  const TriggerEntry({
    required this.id,
    required this.name,
    required this.category,
    required this.isDefault,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['is_default'] = Variable<bool>(isDefault);
    return map;
  }

  TriggersCompanion toCompanion(bool nullToAbsent) {
    return TriggersCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      isDefault: Value(isDefault),
    );
  }

  factory TriggerEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TriggerEntry(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'isDefault': serializer.toJson<bool>(isDefault),
    };
  }

  TriggerEntry copyWith({
    int? id,
    String? name,
    String? category,
    bool? isDefault,
  }) => TriggerEntry(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    isDefault: isDefault ?? this.isDefault,
  );
  TriggerEntry copyWithCompanion(TriggersCompanion data) {
    return TriggerEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TriggerEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, category, isDefault);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TriggerEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.isDefault == this.isDefault);
}

class TriggersCompanion extends UpdateCompanion<TriggerEntry> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<bool> isDefault;
  const TriggersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.isDefault = const Value.absent(),
  });
  TriggersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String category,
    this.isDefault = const Value.absent(),
  }) : name = Value(name),
       category = Value(category);
  static Insertable<TriggerEntry> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<bool>? isDefault,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (isDefault != null) 'is_default': isDefault,
    });
  }

  TriggersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? category,
    Value<bool>? isDefault,
  }) {
    return TriggersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TriggersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }
}

class $EntryTriggersTable extends EntryTriggers
    with TableInfo<$EntryTriggersTable, EntryTrigger> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntryTriggersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<int> entryId = GeneratedColumn<int>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES symptom_entries (id)',
    ),
  );
  static const VerificationMeta _triggerIdMeta = const VerificationMeta(
    'triggerId',
  );
  @override
  late final GeneratedColumn<int> triggerId = GeneratedColumn<int>(
    'trigger_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES triggers (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [entryId, triggerId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entry_triggers';
  @override
  VerificationContext validateIntegrity(
    Insertable<EntryTrigger> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('trigger_id')) {
      context.handle(
        _triggerIdMeta,
        triggerId.isAcceptableOrUnknown(data['trigger_id']!, _triggerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_triggerIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entryId, triggerId};
  @override
  EntryTrigger map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntryTrigger(
      entryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}entry_id'],
          )!,
      triggerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}trigger_id'],
          )!,
    );
  }

  @override
  $EntryTriggersTable createAlias(String alias) {
    return $EntryTriggersTable(attachedDatabase, alias);
  }
}

class EntryTrigger extends DataClass implements Insertable<EntryTrigger> {
  final int entryId;
  final int triggerId;
  const EntryTrigger({required this.entryId, required this.triggerId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entry_id'] = Variable<int>(entryId);
    map['trigger_id'] = Variable<int>(triggerId);
    return map;
  }

  EntryTriggersCompanion toCompanion(bool nullToAbsent) {
    return EntryTriggersCompanion(
      entryId: Value(entryId),
      triggerId: Value(triggerId),
    );
  }

  factory EntryTrigger.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntryTrigger(
      entryId: serializer.fromJson<int>(json['entryId']),
      triggerId: serializer.fromJson<int>(json['triggerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entryId': serializer.toJson<int>(entryId),
      'triggerId': serializer.toJson<int>(triggerId),
    };
  }

  EntryTrigger copyWith({int? entryId, int? triggerId}) => EntryTrigger(
    entryId: entryId ?? this.entryId,
    triggerId: triggerId ?? this.triggerId,
  );
  EntryTrigger copyWithCompanion(EntryTriggersCompanion data) {
    return EntryTrigger(
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      triggerId: data.triggerId.present ? data.triggerId.value : this.triggerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntryTrigger(')
          ..write('entryId: $entryId, ')
          ..write('triggerId: $triggerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(entryId, triggerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntryTrigger &&
          other.entryId == this.entryId &&
          other.triggerId == this.triggerId);
}

class EntryTriggersCompanion extends UpdateCompanion<EntryTrigger> {
  final Value<int> entryId;
  final Value<int> triggerId;
  final Value<int> rowid;
  const EntryTriggersCompanion({
    this.entryId = const Value.absent(),
    this.triggerId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntryTriggersCompanion.insert({
    required int entryId,
    required int triggerId,
    this.rowid = const Value.absent(),
  }) : entryId = Value(entryId),
       triggerId = Value(triggerId);
  static Insertable<EntryTrigger> custom({
    Expression<int>? entryId,
    Expression<int>? triggerId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (entryId != null) 'entry_id': entryId,
      if (triggerId != null) 'trigger_id': triggerId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntryTriggersCompanion copyWith({
    Value<int>? entryId,
    Value<int>? triggerId,
    Value<int>? rowid,
  }) {
    return EntryTriggersCompanion(
      entryId: entryId ?? this.entryId,
      triggerId: triggerId ?? this.triggerId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entryId.present) {
      map['entry_id'] = Variable<int>(entryId.value);
    }
    if (triggerId.present) {
      map['trigger_id'] = Variable<int>(triggerId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntryTriggersCompanion(')
          ..write('entryId: $entryId, ')
          ..write('triggerId: $triggerId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SymptomPresetsTable extends SymptomPresets
    with TableInfo<$SymptomPresetsTable, SymptomPreset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomPresetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, category, isDefault];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptom_presets';
  @override
  VerificationContext validateIntegrity(
    Insertable<SymptomPreset> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SymptomPreset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SymptomPreset(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      category:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category'],
          )!,
      isDefault:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_default'],
          )!,
    );
  }

  @override
  $SymptomPresetsTable createAlias(String alias) {
    return $SymptomPresetsTable(attachedDatabase, alias);
  }
}

class SymptomPreset extends DataClass implements Insertable<SymptomPreset> {
  final int id;
  final String name;
  final String category;
  final bool isDefault;
  const SymptomPreset({
    required this.id,
    required this.name,
    required this.category,
    required this.isDefault,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['is_default'] = Variable<bool>(isDefault);
    return map;
  }

  SymptomPresetsCompanion toCompanion(bool nullToAbsent) {
    return SymptomPresetsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      isDefault: Value(isDefault),
    );
  }

  factory SymptomPreset.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SymptomPreset(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'isDefault': serializer.toJson<bool>(isDefault),
    };
  }

  SymptomPreset copyWith({
    int? id,
    String? name,
    String? category,
    bool? isDefault,
  }) => SymptomPreset(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    isDefault: isDefault ?? this.isDefault,
  );
  SymptomPreset copyWithCompanion(SymptomPresetsCompanion data) {
    return SymptomPreset(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SymptomPreset(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, category, isDefault);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymptomPreset &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.isDefault == this.isDefault);
}

class SymptomPresetsCompanion extends UpdateCompanion<SymptomPreset> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<bool> isDefault;
  const SymptomPresetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.isDefault = const Value.absent(),
  });
  SymptomPresetsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String category,
    this.isDefault = const Value.absent(),
  }) : name = Value(name),
       category = Value(category);
  static Insertable<SymptomPreset> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<bool>? isDefault,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (isDefault != null) 'is_default': isDefault,
    });
  }

  SymptomPresetsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? category,
    Value<bool>? isDefault,
  }) {
    return SymptomPresetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomPresetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeOfDayMeta = const VerificationMeta(
    'timeOfDay',
  );
  @override
  late final GeneratedColumn<String> timeOfDay = GeneratedColumn<String>(
    'time_of_day',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 5,
      maxTextLength: 5,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _daysMeta = const VerificationMeta('days');
  @override
  late final GeneratedColumn<String> days = GeneratedColumn<String>(
    'days',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _intervalHoursMeta = const VerificationMeta(
    'intervalHours',
  );
  @override
  late final GeneratedColumn<int> intervalHours = GeneratedColumn<int>(
    'interval_hours',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    timeOfDay,
    enabled,
    label,
    days,
    intervalHours,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reminder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('time_of_day')) {
      context.handle(
        _timeOfDayMeta,
        timeOfDay.isAcceptableOrUnknown(data['time_of_day']!, _timeOfDayMeta),
      );
    } else if (isInserting) {
      context.missing(_timeOfDayMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('days')) {
      context.handle(
        _daysMeta,
        days.isAcceptableOrUnknown(data['days']!, _daysMeta),
      );
    }
    if (data.containsKey('interval_hours')) {
      context.handle(
        _intervalHoursMeta,
        intervalHours.isAcceptableOrUnknown(
          data['interval_hours']!,
          _intervalHoursMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}type'],
          )!,
      timeOfDay:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}time_of_day'],
          )!,
      enabled:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}enabled'],
          )!,
      label:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}label'],
          )!,
      days:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}days'],
          )!,
      intervalHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_hours'],
      ),
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final int id;
  final String type;
  final String timeOfDay;
  final bool enabled;
  final String label;
  final String days;
  final int? intervalHours;
  const Reminder({
    required this.id,
    required this.type,
    required this.timeOfDay,
    required this.enabled,
    required this.label,
    required this.days,
    this.intervalHours,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['time_of_day'] = Variable<String>(timeOfDay);
    map['enabled'] = Variable<bool>(enabled);
    map['label'] = Variable<String>(label);
    map['days'] = Variable<String>(days);
    if (!nullToAbsent || intervalHours != null) {
      map['interval_hours'] = Variable<int>(intervalHours);
    }
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      type: Value(type),
      timeOfDay: Value(timeOfDay),
      enabled: Value(enabled),
      label: Value(label),
      days: Value(days),
      intervalHours:
          intervalHours == null && nullToAbsent
              ? const Value.absent()
              : Value(intervalHours),
    );
  }

  factory Reminder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      timeOfDay: serializer.fromJson<String>(json['timeOfDay']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      label: serializer.fromJson<String>(json['label']),
      days: serializer.fromJson<String>(json['days']),
      intervalHours: serializer.fromJson<int?>(json['intervalHours']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'timeOfDay': serializer.toJson<String>(timeOfDay),
      'enabled': serializer.toJson<bool>(enabled),
      'label': serializer.toJson<String>(label),
      'days': serializer.toJson<String>(days),
      'intervalHours': serializer.toJson<int?>(intervalHours),
    };
  }

  Reminder copyWith({
    int? id,
    String? type,
    String? timeOfDay,
    bool? enabled,
    String? label,
    String? days,
    Value<int?> intervalHours = const Value.absent(),
  }) => Reminder(
    id: id ?? this.id,
    type: type ?? this.type,
    timeOfDay: timeOfDay ?? this.timeOfDay,
    enabled: enabled ?? this.enabled,
    label: label ?? this.label,
    days: days ?? this.days,
    intervalHours:
        intervalHours.present ? intervalHours.value : this.intervalHours,
  );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      timeOfDay: data.timeOfDay.present ? data.timeOfDay.value : this.timeOfDay,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      label: data.label.present ? data.label.value : this.label,
      days: data.days.present ? data.days.value : this.days,
      intervalHours:
          data.intervalHours.present
              ? data.intervalHours.value
              : this.intervalHours,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('enabled: $enabled, ')
          ..write('label: $label, ')
          ..write('days: $days, ')
          ..write('intervalHours: $intervalHours')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, timeOfDay, enabled, label, days, intervalHours);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.type == this.type &&
          other.timeOfDay == this.timeOfDay &&
          other.enabled == this.enabled &&
          other.label == this.label &&
          other.days == this.days &&
          other.intervalHours == this.intervalHours);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<int> id;
  final Value<String> type;
  final Value<String> timeOfDay;
  final Value<bool> enabled;
  final Value<String> label;
  final Value<String> days;
  final Value<int?> intervalHours;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.enabled = const Value.absent(),
    this.label = const Value.absent(),
    this.days = const Value.absent(),
    this.intervalHours = const Value.absent(),
  });
  RemindersCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required String timeOfDay,
    this.enabled = const Value.absent(),
    this.label = const Value.absent(),
    this.days = const Value.absent(),
    this.intervalHours = const Value.absent(),
  }) : type = Value(type),
       timeOfDay = Value(timeOfDay);
  static Insertable<Reminder> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? timeOfDay,
    Expression<bool>? enabled,
    Expression<String>? label,
    Expression<String>? days,
    Expression<int>? intervalHours,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (timeOfDay != null) 'time_of_day': timeOfDay,
      if (enabled != null) 'enabled': enabled,
      if (label != null) 'label': label,
      if (days != null) 'days': days,
      if (intervalHours != null) 'interval_hours': intervalHours,
    });
  }

  RemindersCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<String>? timeOfDay,
    Value<bool>? enabled,
    Value<String>? label,
    Value<String>? days,
    Value<int?>? intervalHours,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      enabled: enabled ?? this.enabled,
      label: label ?? this.label,
      days: days ?? this.days,
      intervalHours: intervalHours ?? this.intervalHours,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (timeOfDay.present) {
      map['time_of_day'] = Variable<String>(timeOfDay.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (days.present) {
      map['days'] = Variable<String>(days.value);
    }
    if (intervalHours.present) {
      map['interval_hours'] = Variable<int>(intervalHours.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('enabled: $enabled, ')
          ..write('label: $label, ')
          ..write('days: $days, ')
          ..write('intervalHours: $intervalHours')
          ..write(')'))
        .toString();
  }
}

class $SyncMetaTable extends SyncMeta
    with TableInfo<$SyncMetaTable, SyncMetaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncMetaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetaData(
      key:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}key'],
          )!,
      value:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}value'],
          )!,
    );
  }

  @override
  $SyncMetaTable createAlias(String alias) {
    return $SyncMetaTable(attachedDatabase, alias);
  }
}

class SyncMetaData extends DataClass implements Insertable<SyncMetaData> {
  final String key;
  final String value;
  const SyncMetaData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SyncMetaCompanion toCompanion(bool nullToAbsent) {
    return SyncMetaCompanion(key: Value(key), value: Value(value));
  }

  factory SyncMetaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetaData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SyncMetaData copyWith({String? key, String? value}) =>
      SyncMetaData(key: key ?? this.key, value: value ?? this.value);
  SyncMetaData copyWithCompanion(SyncMetaCompanion data) {
    return SyncMetaData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetaData &&
          other.key == this.key &&
          other.value == this.value);
}

class SyncMetaCompanion extends UpdateCompanion<SyncMetaData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SyncMetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetaCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<SyncMetaData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetaCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SyncMetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SymptomEntriesTable symptomEntries = $SymptomEntriesTable(this);
  late final $TriggersTable triggers = $TriggersTable(this);
  late final $EntryTriggersTable entryTriggers = $EntryTriggersTable(this);
  late final $SymptomPresetsTable symptomPresets = $SymptomPresetsTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $SyncMetaTable syncMeta = $SyncMetaTable(this);
  late final SymptomEntryDao symptomEntryDao = SymptomEntryDao(
    this as AppDatabase,
  );
  late final TriggerDao triggerDao = TriggerDao(this as AppDatabase);
  late final SymptomPresetDao symptomPresetDao = SymptomPresetDao(
    this as AppDatabase,
  );
  late final ReminderDao reminderDao = ReminderDao(this as AppDatabase);
  late final SyncMetaDao syncMetaDao = SyncMetaDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    symptomEntries,
    triggers,
    entryTriggers,
    symptomPresets,
    reminders,
    syncMeta,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$SymptomEntriesTableCreateCompanionBuilder =
    SymptomEntriesCompanion Function({
      Value<int> id,
      Value<String?> remoteId,
      required String symptomName,
      required String category,
      required int severity,
      required DateTime startedAt,
      Value<int?> durationMinutes,
      Value<String?> notes,
      Value<String?> reliefAction,
      Value<int?> improvedAfterAction,
      Value<String?> bodyLocation,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> syncedAt,
      Value<bool> deleted,
    });
typedef $$SymptomEntriesTableUpdateCompanionBuilder =
    SymptomEntriesCompanion Function({
      Value<int> id,
      Value<String?> remoteId,
      Value<String> symptomName,
      Value<String> category,
      Value<int> severity,
      Value<DateTime> startedAt,
      Value<int?> durationMinutes,
      Value<String?> notes,
      Value<String?> reliefAction,
      Value<int?> improvedAfterAction,
      Value<String?> bodyLocation,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> syncedAt,
      Value<bool> deleted,
    });

final class $$SymptomEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $SymptomEntriesTable, SymptomEntry> {
  $$SymptomEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$EntryTriggersTable, List<EntryTrigger>>
  _entryTriggersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.entryTriggers,
    aliasName: $_aliasNameGenerator(
      db.symptomEntries.id,
      db.entryTriggers.entryId,
    ),
  );

  $$EntryTriggersTableProcessedTableManager get entryTriggersRefs {
    final manager = $$EntryTriggersTableTableManager(
      $_db,
      $_db.entryTriggers,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_entryTriggersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SymptomEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SymptomEntriesTable> {
  $$SymptomEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symptomName => $composableBuilder(
    column: $table.symptomName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reliefAction => $composableBuilder(
    column: $table.reliefAction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get improvedAfterAction => $composableBuilder(
    column: $table.improvedAfterAction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyLocation => $composableBuilder(
    column: $table.bodyLocation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> entryTriggersRefs(
    Expression<bool> Function($$EntryTriggersTableFilterComposer f) f,
  ) {
    final $$EntryTriggersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entryTriggers,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntryTriggersTableFilterComposer(
            $db: $db,
            $table: $db.entryTriggers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SymptomEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SymptomEntriesTable> {
  $$SymptomEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symptomName => $composableBuilder(
    column: $table.symptomName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reliefAction => $composableBuilder(
    column: $table.reliefAction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get improvedAfterAction => $composableBuilder(
    column: $table.improvedAfterAction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyLocation => $composableBuilder(
    column: $table.bodyLocation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SymptomEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymptomEntriesTable> {
  $$SymptomEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get symptomName => $composableBuilder(
    column: $table.symptomName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get reliefAction => $composableBuilder(
    column: $table.reliefAction,
    builder: (column) => column,
  );

  GeneratedColumn<int> get improvedAfterAction => $composableBuilder(
    column: $table.improvedAfterAction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bodyLocation => $composableBuilder(
    column: $table.bodyLocation,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  Expression<T> entryTriggersRefs<T extends Object>(
    Expression<T> Function($$EntryTriggersTableAnnotationComposer a) f,
  ) {
    final $$EntryTriggersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entryTriggers,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntryTriggersTableAnnotationComposer(
            $db: $db,
            $table: $db.entryTriggers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SymptomEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SymptomEntriesTable,
          SymptomEntry,
          $$SymptomEntriesTableFilterComposer,
          $$SymptomEntriesTableOrderingComposer,
          $$SymptomEntriesTableAnnotationComposer,
          $$SymptomEntriesTableCreateCompanionBuilder,
          $$SymptomEntriesTableUpdateCompanionBuilder,
          (SymptomEntry, $$SymptomEntriesTableReferences),
          SymptomEntry,
          PrefetchHooks Function({bool entryTriggersRefs})
        > {
  $$SymptomEntriesTableTableManager(
    _$AppDatabase db,
    $SymptomEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SymptomEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$SymptomEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SymptomEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String> symptomName = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> severity = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> reliefAction = const Value.absent(),
                Value<int?> improvedAfterAction = const Value.absent(),
                Value<String?> bodyLocation = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
              }) => SymptomEntriesCompanion(
                id: id,
                remoteId: remoteId,
                symptomName: symptomName,
                category: category,
                severity: severity,
                startedAt: startedAt,
                durationMinutes: durationMinutes,
                notes: notes,
                reliefAction: reliefAction,
                improvedAfterAction: improvedAfterAction,
                bodyLocation: bodyLocation,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                deleted: deleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                required String symptomName,
                required String category,
                required int severity,
                required DateTime startedAt,
                Value<int?> durationMinutes = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> reliefAction = const Value.absent(),
                Value<int?> improvedAfterAction = const Value.absent(),
                Value<String?> bodyLocation = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
              }) => SymptomEntriesCompanion.insert(
                id: id,
                remoteId: remoteId,
                symptomName: symptomName,
                category: category,
                severity: severity,
                startedAt: startedAt,
                durationMinutes: durationMinutes,
                notes: notes,
                reliefAction: reliefAction,
                improvedAfterAction: improvedAfterAction,
                bodyLocation: bodyLocation,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                deleted: deleted,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$SymptomEntriesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({entryTriggersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (entryTriggersRefs) db.entryTriggers,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (entryTriggersRefs)
                    await $_getPrefetchedData<
                      SymptomEntry,
                      $SymptomEntriesTable,
                      EntryTrigger
                    >(
                      currentTable: table,
                      referencedTable: $$SymptomEntriesTableReferences
                          ._entryTriggersRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$SymptomEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).entryTriggersRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.entryId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SymptomEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SymptomEntriesTable,
      SymptomEntry,
      $$SymptomEntriesTableFilterComposer,
      $$SymptomEntriesTableOrderingComposer,
      $$SymptomEntriesTableAnnotationComposer,
      $$SymptomEntriesTableCreateCompanionBuilder,
      $$SymptomEntriesTableUpdateCompanionBuilder,
      (SymptomEntry, $$SymptomEntriesTableReferences),
      SymptomEntry,
      PrefetchHooks Function({bool entryTriggersRefs})
    >;
typedef $$TriggersTableCreateCompanionBuilder =
    TriggersCompanion Function({
      Value<int> id,
      required String name,
      required String category,
      Value<bool> isDefault,
    });
typedef $$TriggersTableUpdateCompanionBuilder =
    TriggersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> category,
      Value<bool> isDefault,
    });

final class $$TriggersTableReferences
    extends BaseReferences<_$AppDatabase, $TriggersTable, TriggerEntry> {
  $$TriggersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EntryTriggersTable, List<EntryTrigger>>
  _entryTriggersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.entryTriggers,
    aliasName: $_aliasNameGenerator(db.triggers.id, db.entryTriggers.triggerId),
  );

  $$EntryTriggersTableProcessedTableManager get entryTriggersRefs {
    final manager = $$EntryTriggersTableTableManager(
      $_db,
      $_db.entryTriggers,
    ).filter((f) => f.triggerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_entryTriggersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TriggersTableFilterComposer
    extends Composer<_$AppDatabase, $TriggersTable> {
  $$TriggersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> entryTriggersRefs(
    Expression<bool> Function($$EntryTriggersTableFilterComposer f) f,
  ) {
    final $$EntryTriggersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entryTriggers,
      getReferencedColumn: (t) => t.triggerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntryTriggersTableFilterComposer(
            $db: $db,
            $table: $db.entryTriggers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TriggersTableOrderingComposer
    extends Composer<_$AppDatabase, $TriggersTable> {
  $$TriggersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TriggersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TriggersTable> {
  $$TriggersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  Expression<T> entryTriggersRefs<T extends Object>(
    Expression<T> Function($$EntryTriggersTableAnnotationComposer a) f,
  ) {
    final $$EntryTriggersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entryTriggers,
      getReferencedColumn: (t) => t.triggerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntryTriggersTableAnnotationComposer(
            $db: $db,
            $table: $db.entryTriggers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TriggersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TriggersTable,
          TriggerEntry,
          $$TriggersTableFilterComposer,
          $$TriggersTableOrderingComposer,
          $$TriggersTableAnnotationComposer,
          $$TriggersTableCreateCompanionBuilder,
          $$TriggersTableUpdateCompanionBuilder,
          (TriggerEntry, $$TriggersTableReferences),
          TriggerEntry,
          PrefetchHooks Function({bool entryTriggersRefs})
        > {
  $$TriggersTableTableManager(_$AppDatabase db, $TriggersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TriggersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$TriggersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$TriggersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
              }) => TriggersCompanion(
                id: id,
                name: name,
                category: category,
                isDefault: isDefault,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String category,
                Value<bool> isDefault = const Value.absent(),
              }) => TriggersCompanion.insert(
                id: id,
                name: name,
                category: category,
                isDefault: isDefault,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$TriggersTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({entryTriggersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (entryTriggersRefs) db.entryTriggers,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (entryTriggersRefs)
                    await $_getPrefetchedData<
                      TriggerEntry,
                      $TriggersTable,
                      EntryTrigger
                    >(
                      currentTable: table,
                      referencedTable: $$TriggersTableReferences
                          ._entryTriggersRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$TriggersTableReferences(
                                db,
                                table,
                                p0,
                              ).entryTriggersRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.triggerId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TriggersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TriggersTable,
      TriggerEntry,
      $$TriggersTableFilterComposer,
      $$TriggersTableOrderingComposer,
      $$TriggersTableAnnotationComposer,
      $$TriggersTableCreateCompanionBuilder,
      $$TriggersTableUpdateCompanionBuilder,
      (TriggerEntry, $$TriggersTableReferences),
      TriggerEntry,
      PrefetchHooks Function({bool entryTriggersRefs})
    >;
typedef $$EntryTriggersTableCreateCompanionBuilder =
    EntryTriggersCompanion Function({
      required int entryId,
      required int triggerId,
      Value<int> rowid,
    });
typedef $$EntryTriggersTableUpdateCompanionBuilder =
    EntryTriggersCompanion Function({
      Value<int> entryId,
      Value<int> triggerId,
      Value<int> rowid,
    });

final class $$EntryTriggersTableReferences
    extends BaseReferences<_$AppDatabase, $EntryTriggersTable, EntryTrigger> {
  $$EntryTriggersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SymptomEntriesTable _entryIdTable(_$AppDatabase db) =>
      db.symptomEntries.createAlias(
        $_aliasNameGenerator(db.entryTriggers.entryId, db.symptomEntries.id),
      );

  $$SymptomEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<int>('entry_id')!;

    final manager = $$SymptomEntriesTableTableManager(
      $_db,
      $_db.symptomEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TriggersTable _triggerIdTable(_$AppDatabase db) =>
      db.triggers.createAlias(
        $_aliasNameGenerator(db.entryTriggers.triggerId, db.triggers.id),
      );

  $$TriggersTableProcessedTableManager get triggerId {
    final $_column = $_itemColumn<int>('trigger_id')!;

    final manager = $$TriggersTableTableManager(
      $_db,
      $_db.triggers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_triggerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EntryTriggersTableFilterComposer
    extends Composer<_$AppDatabase, $EntryTriggersTable> {
  $$EntryTriggersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SymptomEntriesTableFilterComposer get entryId {
    final $$SymptomEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.symptomEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SymptomEntriesTableFilterComposer(
            $db: $db,
            $table: $db.symptomEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TriggersTableFilterComposer get triggerId {
    final $$TriggersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.triggerId,
      referencedTable: $db.triggers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriggersTableFilterComposer(
            $db: $db,
            $table: $db.triggers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntryTriggersTableOrderingComposer
    extends Composer<_$AppDatabase, $EntryTriggersTable> {
  $$EntryTriggersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SymptomEntriesTableOrderingComposer get entryId {
    final $$SymptomEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.symptomEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SymptomEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.symptomEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TriggersTableOrderingComposer get triggerId {
    final $$TriggersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.triggerId,
      referencedTable: $db.triggers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriggersTableOrderingComposer(
            $db: $db,
            $table: $db.triggers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntryTriggersTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntryTriggersTable> {
  $$EntryTriggersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SymptomEntriesTableAnnotationComposer get entryId {
    final $$SymptomEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.symptomEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SymptomEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.symptomEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TriggersTableAnnotationComposer get triggerId {
    final $$TriggersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.triggerId,
      referencedTable: $db.triggers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TriggersTableAnnotationComposer(
            $db: $db,
            $table: $db.triggers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntryTriggersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EntryTriggersTable,
          EntryTrigger,
          $$EntryTriggersTableFilterComposer,
          $$EntryTriggersTableOrderingComposer,
          $$EntryTriggersTableAnnotationComposer,
          $$EntryTriggersTableCreateCompanionBuilder,
          $$EntryTriggersTableUpdateCompanionBuilder,
          (EntryTrigger, $$EntryTriggersTableReferences),
          EntryTrigger,
          PrefetchHooks Function({bool entryId, bool triggerId})
        > {
  $$EntryTriggersTableTableManager(_$AppDatabase db, $EntryTriggersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$EntryTriggersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$EntryTriggersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$EntryTriggersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> entryId = const Value.absent(),
                Value<int> triggerId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntryTriggersCompanion(
                entryId: entryId,
                triggerId: triggerId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int entryId,
                required int triggerId,
                Value<int> rowid = const Value.absent(),
              }) => EntryTriggersCompanion.insert(
                entryId: entryId,
                triggerId: triggerId,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$EntryTriggersTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({entryId = false, triggerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (entryId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.entryId,
                            referencedTable: $$EntryTriggersTableReferences
                                ._entryIdTable(db),
                            referencedColumn:
                                $$EntryTriggersTableReferences
                                    ._entryIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (triggerId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.triggerId,
                            referencedTable: $$EntryTriggersTableReferences
                                ._triggerIdTable(db),
                            referencedColumn:
                                $$EntryTriggersTableReferences
                                    ._triggerIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EntryTriggersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EntryTriggersTable,
      EntryTrigger,
      $$EntryTriggersTableFilterComposer,
      $$EntryTriggersTableOrderingComposer,
      $$EntryTriggersTableAnnotationComposer,
      $$EntryTriggersTableCreateCompanionBuilder,
      $$EntryTriggersTableUpdateCompanionBuilder,
      (EntryTrigger, $$EntryTriggersTableReferences),
      EntryTrigger,
      PrefetchHooks Function({bool entryId, bool triggerId})
    >;
typedef $$SymptomPresetsTableCreateCompanionBuilder =
    SymptomPresetsCompanion Function({
      Value<int> id,
      required String name,
      required String category,
      Value<bool> isDefault,
    });
typedef $$SymptomPresetsTableUpdateCompanionBuilder =
    SymptomPresetsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> category,
      Value<bool> isDefault,
    });

class $$SymptomPresetsTableFilterComposer
    extends Composer<_$AppDatabase, $SymptomPresetsTable> {
  $$SymptomPresetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SymptomPresetsTableOrderingComposer
    extends Composer<_$AppDatabase, $SymptomPresetsTable> {
  $$SymptomPresetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SymptomPresetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymptomPresetsTable> {
  $$SymptomPresetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);
}

class $$SymptomPresetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SymptomPresetsTable,
          SymptomPreset,
          $$SymptomPresetsTableFilterComposer,
          $$SymptomPresetsTableOrderingComposer,
          $$SymptomPresetsTableAnnotationComposer,
          $$SymptomPresetsTableCreateCompanionBuilder,
          $$SymptomPresetsTableUpdateCompanionBuilder,
          (
            SymptomPreset,
            BaseReferences<_$AppDatabase, $SymptomPresetsTable, SymptomPreset>,
          ),
          SymptomPreset,
          PrefetchHooks Function()
        > {
  $$SymptomPresetsTableTableManager(
    _$AppDatabase db,
    $SymptomPresetsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SymptomPresetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$SymptomPresetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SymptomPresetsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
              }) => SymptomPresetsCompanion(
                id: id,
                name: name,
                category: category,
                isDefault: isDefault,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String category,
                Value<bool> isDefault = const Value.absent(),
              }) => SymptomPresetsCompanion.insert(
                id: id,
                name: name,
                category: category,
                isDefault: isDefault,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SymptomPresetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SymptomPresetsTable,
      SymptomPreset,
      $$SymptomPresetsTableFilterComposer,
      $$SymptomPresetsTableOrderingComposer,
      $$SymptomPresetsTableAnnotationComposer,
      $$SymptomPresetsTableCreateCompanionBuilder,
      $$SymptomPresetsTableUpdateCompanionBuilder,
      (
        SymptomPreset,
        BaseReferences<_$AppDatabase, $SymptomPresetsTable, SymptomPreset>,
      ),
      SymptomPreset,
      PrefetchHooks Function()
    >;
typedef $$RemindersTableCreateCompanionBuilder =
    RemindersCompanion Function({
      Value<int> id,
      required String type,
      required String timeOfDay,
      Value<bool> enabled,
      Value<String> label,
      Value<String> days,
      Value<int?> intervalHours,
    });
typedef $$RemindersTableUpdateCompanionBuilder =
    RemindersCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<String> timeOfDay,
      Value<bool> enabled,
      Value<String> label,
      Value<String> days,
      Value<int?> intervalHours,
    });

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get days => $composableBuilder(
    column: $table.days,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalHours => $composableBuilder(
    column: $table.intervalHours,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get days => $composableBuilder(
    column: $table.days,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalHours => $composableBuilder(
    column: $table.intervalHours,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get timeOfDay =>
      $composableBuilder(column: $table.timeOfDay, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get days =>
      $composableBuilder(column: $table.days, builder: (column) => column);

  GeneratedColumn<int> get intervalHours => $composableBuilder(
    column: $table.intervalHours,
    builder: (column) => column,
  );
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          Reminder,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
          Reminder,
          PrefetchHooks Function()
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> timeOfDay = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String> days = const Value.absent(),
                Value<int?> intervalHours = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                type: type,
                timeOfDay: timeOfDay,
                enabled: enabled,
                label: label,
                days: days,
                intervalHours: intervalHours,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                required String timeOfDay,
                Value<bool> enabled = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String> days = const Value.absent(),
                Value<int?> intervalHours = const Value.absent(),
              }) => RemindersCompanion.insert(
                id: id,
                type: type,
                timeOfDay: timeOfDay,
                enabled: enabled,
                label: label,
                days: days,
                intervalHours: intervalHours,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      Reminder,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
      Reminder,
      PrefetchHooks Function()
    >;
typedef $$SyncMetaTableCreateCompanionBuilder =
    SyncMetaCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$SyncMetaTableUpdateCompanionBuilder =
    SyncMetaCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$SyncMetaTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SyncMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetaTable,
          SyncMetaData,
          $$SyncMetaTableFilterComposer,
          $$SyncMetaTableOrderingComposer,
          $$SyncMetaTableAnnotationComposer,
          $$SyncMetaTableCreateCompanionBuilder,
          $$SyncMetaTableUpdateCompanionBuilder,
          (
            SyncMetaData,
            BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaData>,
          ),
          SyncMetaData,
          PrefetchHooks Function()
        > {
  $$SyncMetaTableTableManager(_$AppDatabase db, $SyncMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SyncMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SyncMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SyncMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetaCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => SyncMetaCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetaTable,
      SyncMetaData,
      $$SyncMetaTableFilterComposer,
      $$SyncMetaTableOrderingComposer,
      $$SyncMetaTableAnnotationComposer,
      $$SyncMetaTableCreateCompanionBuilder,
      $$SyncMetaTableUpdateCompanionBuilder,
      (
        SyncMetaData,
        BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaData>,
      ),
      SyncMetaData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SymptomEntriesTableTableManager get symptomEntries =>
      $$SymptomEntriesTableTableManager(_db, _db.symptomEntries);
  $$TriggersTableTableManager get triggers =>
      $$TriggersTableTableManager(_db, _db.triggers);
  $$EntryTriggersTableTableManager get entryTriggers =>
      $$EntryTriggersTableTableManager(_db, _db.entryTriggers);
  $$SymptomPresetsTableTableManager get symptomPresets =>
      $$SymptomPresetsTableTableManager(_db, _db.symptomPresets);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$SyncMetaTableTableManager get syncMeta =>
      $$SyncMetaTableTableManager(_db, _db.syncMeta);
}
