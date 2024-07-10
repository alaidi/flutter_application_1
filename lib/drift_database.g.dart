// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $DepartmentsTable extends Departments
    with TableInfo<$DepartmentsTable, Department> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DepartmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'departments';
  @override
  VerificationContext validateIntegrity(Insertable<Department> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Department map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Department(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $DepartmentsTable createAlias(String alias) {
    return $DepartmentsTable(attachedDatabase, alias);
  }
}

class Department extends DataClass implements Insertable<Department> {
  final int id;
  final String name;
  const Department({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  DepartmentsCompanion toCompanion(bool nullToAbsent) {
    return DepartmentsCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Department.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Department(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Department copyWith({int? id, String? name}) => Department(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Department(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Department && other.id == this.id && other.name == this.name);
}

class DepartmentsCompanion extends UpdateCompanion<Department> {
  final Value<int> id;
  final Value<String> name;
  const DepartmentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  DepartmentsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Department> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  DepartmentsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return DepartmentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DepartmentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $EmployeesTable extends Employees
    with TableInfo<$EmployeesTable, Employee> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _statisticalNumberMeta =
      const VerificationMeta('statisticalNumber');
  @override
  late final GeneratedColumn<int> statisticalNumber = GeneratedColumn<int>(
      'statistical_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _rankMeta = const VerificationMeta('rank');
  @override
  late final GeneratedColumn<String> rank = GeneratedColumn<String>(
      'rank', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
      'position', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _departmentIdMeta =
      const VerificationMeta('departmentId');
  @override
  late final GeneratedColumn<int> departmentId = GeneratedColumn<int>(
      'department_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES departments(id) NOT NULL');
  static const VerificationMeta _subjectMeta =
      const VerificationMeta('subject');
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
      'subject', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _filePathMeta =
      const VerificationMeta('filePath');
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
      'file_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastUpdateMeta =
      const VerificationMeta('lastUpdate');
  @override
  late final GeneratedColumn<DateTime> lastUpdate = GeneratedColumn<DateTime>(
      'last_update', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        fullName,
        statisticalNumber,
        rank,
        position,
        departmentId,
        subject,
        status,
        notes,
        filePath,
        lastUpdate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employees';
  @override
  VerificationContext validateIntegrity(Insertable<Employee> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('statistical_number')) {
      context.handle(
          _statisticalNumberMeta,
          statisticalNumber.isAcceptableOrUnknown(
              data['statistical_number']!, _statisticalNumberMeta));
    } else if (isInserting) {
      context.missing(_statisticalNumberMeta);
    }
    if (data.containsKey('rank')) {
      context.handle(
          _rankMeta, rank.isAcceptableOrUnknown(data['rank']!, _rankMeta));
    } else if (isInserting) {
      context.missing(_rankMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('department_id')) {
      context.handle(
          _departmentIdMeta,
          departmentId.isAcceptableOrUnknown(
              data['department_id']!, _departmentIdMeta));
    } else if (isInserting) {
      context.missing(_departmentIdMeta);
    }
    if (data.containsKey('subject')) {
      context.handle(_subjectMeta,
          subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta));
    } else if (isInserting) {
      context.missing(_subjectMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('file_path')) {
      context.handle(_filePathMeta,
          filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta));
    }
    if (data.containsKey('last_update')) {
      context.handle(
          _lastUpdateMeta,
          lastUpdate.isAcceptableOrUnknown(
              data['last_update']!, _lastUpdateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Employee map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Employee(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      statisticalNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}statistical_number'])!,
      rank: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rank'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}position'])!,
      departmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}department_id'])!,
      subject: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subject'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      filePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_path']),
      lastUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_update'])!,
    );
  }

  @override
  $EmployeesTable createAlias(String alias) {
    return $EmployeesTable(attachedDatabase, alias);
  }
}

class Employee extends DataClass implements Insertable<Employee> {
  final int id;
  final String fullName;
  final int statisticalNumber;
  final String rank;
  final String position;
  final int departmentId;
  final String subject;
  final String status;
  final String? notes;
  final String? filePath;
  final DateTime lastUpdate;
  const Employee(
      {required this.id,
      required this.fullName,
      required this.statisticalNumber,
      required this.rank,
      required this.position,
      required this.departmentId,
      required this.subject,
      required this.status,
      this.notes,
      this.filePath,
      required this.lastUpdate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['full_name'] = Variable<String>(fullName);
    map['statistical_number'] = Variable<int>(statisticalNumber);
    map['rank'] = Variable<String>(rank);
    map['position'] = Variable<String>(position);
    map['department_id'] = Variable<int>(departmentId);
    map['subject'] = Variable<String>(subject);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || filePath != null) {
      map['file_path'] = Variable<String>(filePath);
    }
    map['last_update'] = Variable<DateTime>(lastUpdate);
    return map;
  }

  EmployeesCompanion toCompanion(bool nullToAbsent) {
    return EmployeesCompanion(
      id: Value(id),
      fullName: Value(fullName),
      statisticalNumber: Value(statisticalNumber),
      rank: Value(rank),
      position: Value(position),
      departmentId: Value(departmentId),
      subject: Value(subject),
      status: Value(status),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      filePath: filePath == null && nullToAbsent
          ? const Value.absent()
          : Value(filePath),
      lastUpdate: Value(lastUpdate),
    );
  }

  factory Employee.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Employee(
      id: serializer.fromJson<int>(json['id']),
      fullName: serializer.fromJson<String>(json['fullName']),
      statisticalNumber: serializer.fromJson<int>(json['statisticalNumber']),
      rank: serializer.fromJson<String>(json['rank']),
      position: serializer.fromJson<String>(json['position']),
      departmentId: serializer.fromJson<int>(json['departmentId']),
      subject: serializer.fromJson<String>(json['subject']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      filePath: serializer.fromJson<String?>(json['filePath']),
      lastUpdate: serializer.fromJson<DateTime>(json['lastUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fullName': serializer.toJson<String>(fullName),
      'statisticalNumber': serializer.toJson<int>(statisticalNumber),
      'rank': serializer.toJson<String>(rank),
      'position': serializer.toJson<String>(position),
      'departmentId': serializer.toJson<int>(departmentId),
      'subject': serializer.toJson<String>(subject),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'filePath': serializer.toJson<String?>(filePath),
      'lastUpdate': serializer.toJson<DateTime>(lastUpdate),
    };
  }

  Employee copyWith(
          {int? id,
          String? fullName,
          int? statisticalNumber,
          String? rank,
          String? position,
          int? departmentId,
          String? subject,
          String? status,
          Value<String?> notes = const Value.absent(),
          Value<String?> filePath = const Value.absent(),
          DateTime? lastUpdate}) =>
      Employee(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        statisticalNumber: statisticalNumber ?? this.statisticalNumber,
        rank: rank ?? this.rank,
        position: position ?? this.position,
        departmentId: departmentId ?? this.departmentId,
        subject: subject ?? this.subject,
        status: status ?? this.status,
        notes: notes.present ? notes.value : this.notes,
        filePath: filePath.present ? filePath.value : this.filePath,
        lastUpdate: lastUpdate ?? this.lastUpdate,
      );
  @override
  String toString() {
    return (StringBuffer('Employee(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('statisticalNumber: $statisticalNumber, ')
          ..write('rank: $rank, ')
          ..write('position: $position, ')
          ..write('departmentId: $departmentId, ')
          ..write('subject: $subject, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('filePath: $filePath, ')
          ..write('lastUpdate: $lastUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fullName, statisticalNumber, rank,
      position, departmentId, subject, status, notes, filePath, lastUpdate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Employee &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.statisticalNumber == this.statisticalNumber &&
          other.rank == this.rank &&
          other.position == this.position &&
          other.departmentId == this.departmentId &&
          other.subject == this.subject &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.filePath == this.filePath &&
          other.lastUpdate == this.lastUpdate);
}

class EmployeesCompanion extends UpdateCompanion<Employee> {
  final Value<int> id;
  final Value<String> fullName;
  final Value<int> statisticalNumber;
  final Value<String> rank;
  final Value<String> position;
  final Value<int> departmentId;
  final Value<String> subject;
  final Value<String> status;
  final Value<String?> notes;
  final Value<String?> filePath;
  final Value<DateTime> lastUpdate;
  const EmployeesCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.statisticalNumber = const Value.absent(),
    this.rank = const Value.absent(),
    this.position = const Value.absent(),
    this.departmentId = const Value.absent(),
    this.subject = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.filePath = const Value.absent(),
    this.lastUpdate = const Value.absent(),
  });
  EmployeesCompanion.insert({
    this.id = const Value.absent(),
    required String fullName,
    required int statisticalNumber,
    required String rank,
    required String position,
    required int departmentId,
    required String subject,
    required String status,
    this.notes = const Value.absent(),
    this.filePath = const Value.absent(),
    this.lastUpdate = const Value.absent(),
  })  : fullName = Value(fullName),
        statisticalNumber = Value(statisticalNumber),
        rank = Value(rank),
        position = Value(position),
        departmentId = Value(departmentId),
        subject = Value(subject),
        status = Value(status);
  static Insertable<Employee> custom({
    Expression<int>? id,
    Expression<String>? fullName,
    Expression<int>? statisticalNumber,
    Expression<String>? rank,
    Expression<String>? position,
    Expression<int>? departmentId,
    Expression<String>? subject,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<String>? filePath,
    Expression<DateTime>? lastUpdate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (statisticalNumber != null) 'statistical_number': statisticalNumber,
      if (rank != null) 'rank': rank,
      if (position != null) 'position': position,
      if (departmentId != null) 'department_id': departmentId,
      if (subject != null) 'subject': subject,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (filePath != null) 'file_path': filePath,
      if (lastUpdate != null) 'last_update': lastUpdate,
    });
  }

  EmployeesCompanion copyWith(
      {Value<int>? id,
      Value<String>? fullName,
      Value<int>? statisticalNumber,
      Value<String>? rank,
      Value<String>? position,
      Value<int>? departmentId,
      Value<String>? subject,
      Value<String>? status,
      Value<String?>? notes,
      Value<String?>? filePath,
      Value<DateTime>? lastUpdate}) {
    return EmployeesCompanion(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      statisticalNumber: statisticalNumber ?? this.statisticalNumber,
      rank: rank ?? this.rank,
      position: position ?? this.position,
      departmentId: departmentId ?? this.departmentId,
      subject: subject ?? this.subject,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      filePath: filePath ?? this.filePath,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (statisticalNumber.present) {
      map['statistical_number'] = Variable<int>(statisticalNumber.value);
    }
    if (rank.present) {
      map['rank'] = Variable<String>(rank.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (departmentId.present) {
      map['department_id'] = Variable<int>(departmentId.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<DateTime>(lastUpdate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('statisticalNumber: $statisticalNumber, ')
          ..write('rank: $rank, ')
          ..write('position: $position, ')
          ..write('departmentId: $departmentId, ')
          ..write('subject: $subject, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('filePath: $filePath, ')
          ..write('lastUpdate: $lastUpdate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $DepartmentsTable departments = $DepartmentsTable(this);
  late final $EmployeesTable employees = $EmployeesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [departments, employees];
}

typedef $$DepartmentsTableInsertCompanionBuilder = DepartmentsCompanion
    Function({
  Value<int> id,
  required String name,
});
typedef $$DepartmentsTableUpdateCompanionBuilder = DepartmentsCompanion
    Function({
  Value<int> id,
  Value<String> name,
});

class $$DepartmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DepartmentsTable,
    Department,
    $$DepartmentsTableFilterComposer,
    $$DepartmentsTableOrderingComposer,
    $$DepartmentsTableProcessedTableManager,
    $$DepartmentsTableInsertCompanionBuilder,
    $$DepartmentsTableUpdateCompanionBuilder> {
  $$DepartmentsTableTableManager(_$AppDatabase db, $DepartmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$DepartmentsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$DepartmentsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$DepartmentsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) =>
              DepartmentsCompanion(
            id: id,
            name: name,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) =>
              DepartmentsCompanion.insert(
            id: id,
            name: name,
          ),
        ));
}

class $$DepartmentsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $DepartmentsTable,
    Department,
    $$DepartmentsTableFilterComposer,
    $$DepartmentsTableOrderingComposer,
    $$DepartmentsTableProcessedTableManager,
    $$DepartmentsTableInsertCompanionBuilder,
    $$DepartmentsTableUpdateCompanionBuilder> {
  $$DepartmentsTableProcessedTableManager(super.$state);
}

class $$DepartmentsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $DepartmentsTable> {
  $$DepartmentsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter employeesRefs(
      ComposableFilter Function($$EmployeesTableFilterComposer f) f) {
    final $$EmployeesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.employees,
        getReferencedColumn: (t) => t.departmentId,
        builder: (joinBuilder, parentComposers) =>
            $$EmployeesTableFilterComposer(ComposerState(
                $state.db, $state.db.employees, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$DepartmentsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $DepartmentsTable> {
  $$DepartmentsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$EmployeesTableInsertCompanionBuilder = EmployeesCompanion Function({
  Value<int> id,
  required String fullName,
  required int statisticalNumber,
  required String rank,
  required String position,
  required int departmentId,
  required String subject,
  required String status,
  Value<String?> notes,
  Value<String?> filePath,
  Value<DateTime> lastUpdate,
});
typedef $$EmployeesTableUpdateCompanionBuilder = EmployeesCompanion Function({
  Value<int> id,
  Value<String> fullName,
  Value<int> statisticalNumber,
  Value<String> rank,
  Value<String> position,
  Value<int> departmentId,
  Value<String> subject,
  Value<String> status,
  Value<String?> notes,
  Value<String?> filePath,
  Value<DateTime> lastUpdate,
});

class $$EmployeesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EmployeesTable,
    Employee,
    $$EmployeesTableFilterComposer,
    $$EmployeesTableOrderingComposer,
    $$EmployeesTableProcessedTableManager,
    $$EmployeesTableInsertCompanionBuilder,
    $$EmployeesTableUpdateCompanionBuilder> {
  $$EmployeesTableTableManager(_$AppDatabase db, $EmployeesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$EmployeesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$EmployeesTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$EmployeesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<int> statisticalNumber = const Value.absent(),
            Value<String> rank = const Value.absent(),
            Value<String> position = const Value.absent(),
            Value<int> departmentId = const Value.absent(),
            Value<String> subject = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> filePath = const Value.absent(),
            Value<DateTime> lastUpdate = const Value.absent(),
          }) =>
              EmployeesCompanion(
            id: id,
            fullName: fullName,
            statisticalNumber: statisticalNumber,
            rank: rank,
            position: position,
            departmentId: departmentId,
            subject: subject,
            status: status,
            notes: notes,
            filePath: filePath,
            lastUpdate: lastUpdate,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String fullName,
            required int statisticalNumber,
            required String rank,
            required String position,
            required int departmentId,
            required String subject,
            required String status,
            Value<String?> notes = const Value.absent(),
            Value<String?> filePath = const Value.absent(),
            Value<DateTime> lastUpdate = const Value.absent(),
          }) =>
              EmployeesCompanion.insert(
            id: id,
            fullName: fullName,
            statisticalNumber: statisticalNumber,
            rank: rank,
            position: position,
            departmentId: departmentId,
            subject: subject,
            status: status,
            notes: notes,
            filePath: filePath,
            lastUpdate: lastUpdate,
          ),
        ));
}

class $$EmployeesTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $EmployeesTable,
    Employee,
    $$EmployeesTableFilterComposer,
    $$EmployeesTableOrderingComposer,
    $$EmployeesTableProcessedTableManager,
    $$EmployeesTableInsertCompanionBuilder,
    $$EmployeesTableUpdateCompanionBuilder> {
  $$EmployeesTableProcessedTableManager(super.$state);
}

class $$EmployeesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get fullName => $state.composableBuilder(
      column: $state.table.fullName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get statisticalNumber => $state.composableBuilder(
      column: $state.table.statisticalNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get rank => $state.composableBuilder(
      column: $state.table.rank,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get position => $state.composableBuilder(
      column: $state.table.position,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get subject => $state.composableBuilder(
      column: $state.table.subject,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get filePath => $state.composableBuilder(
      column: $state.table.filePath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get lastUpdate => $state.composableBuilder(
      column: $state.table.lastUpdate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$DepartmentsTableFilterComposer get departmentId {
    final $$DepartmentsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.departmentId,
        referencedTable: $state.db.departments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$DepartmentsTableFilterComposer(ComposerState($state.db,
                $state.db.departments, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$EmployeesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get fullName => $state.composableBuilder(
      column: $state.table.fullName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get statisticalNumber => $state.composableBuilder(
      column: $state.table.statisticalNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get rank => $state.composableBuilder(
      column: $state.table.rank,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get position => $state.composableBuilder(
      column: $state.table.position,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get subject => $state.composableBuilder(
      column: $state.table.subject,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get filePath => $state.composableBuilder(
      column: $state.table.filePath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get lastUpdate => $state.composableBuilder(
      column: $state.table.lastUpdate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$DepartmentsTableOrderingComposer get departmentId {
    final $$DepartmentsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.departmentId,
        referencedTable: $state.db.departments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$DepartmentsTableOrderingComposer(ComposerState($state.db,
                $state.db.departments, joinBuilder, parentComposers)));
    return composer;
  }
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$DepartmentsTableTableManager get departments =>
      $$DepartmentsTableTableManager(_db, _db.departments);
  $$EmployeesTableTableManager get employees =>
      $$EmployeesTableTableManager(_db, _db.employees);
}
