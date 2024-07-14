import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:path/path.dart' as path;

part 'drift_database.g.dart';

@DriftDatabase(tables: [Employees, Departments])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;
//   @override
//   MigrationStrategy get migration => MigrationStrategy(
//         onCreate: (Migrator m) {
//           return m.createAll();
//         },
//         onUpgrade: (Migrator m, int from, int to) async {
//           if (from == 1) {
//             await m.addColumn(employees, employees.filePath);
//           }
//         },
//       );
}

Future<void> _initializeDirectories(Directory pdfDir) async {
  // final Directory appDir = Directory.current;
//  final pdfDir = Directory(path.join(appDir.path, 'data'));

  if (!await pdfDir.exists()) {
    await pdfDir.create(recursive: true);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory appDir = Directory.current;
    final pdfDir = Directory(path.join(appDir.path, 'data'));

    await _initializeDirectories(pdfDir);
    //  final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(pdfDir.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

class Employees extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fullName => text().withLength(min: 1, max: 50)();
  IntColumn get statisticalNumber => integer()();
  TextColumn get rank => text().withLength(min: 1, max: 20)();
  TextColumn get position => text().withLength(min: 1, max: 20)();
  IntColumn get departmentId =>
      integer().customConstraint('REFERENCES departments(id) NOT NULL')();
  TextColumn get subject => text().withLength(min: 1, max: 20)();
  TextColumn get status => text().withLength(min: 1, max: 20)();
  TextColumn get notes => text().nullable()();
  TextColumn get filePath => text().nullable()();
  DateTimeColumn get lastUpdate => dateTime().withDefault(currentDateAndTime)();
}

class Departments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
}
