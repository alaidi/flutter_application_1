import 'dart:async';
import 'package:flutter_application_1/drift_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeEvent {}

class AddEmployee extends EmployeeEvent {
  final EmployeesCompanion employee;
  final Completer<int> completer;

  AddEmployee(this.employee, this.completer);
  List<Object> get props => [employee];
}

class DeleteEmployee extends EmployeeEvent {
  final int id;

  DeleteEmployee(this.id);
}

class UpdateEmployee extends EmployeeEvent {
  final EmployeesCompanion employee;

  UpdateEmployee(this.employee);
}

class FetchEmployees extends EmployeeEvent {}

class EmployeeState {}

class EmployeeWithDepartment {
  final Employee employee;
  final String departmentName;

  EmployeeWithDepartment({
    required this.employee,
    required this.departmentName,
  });
}

class EmployeeLoaded extends EmployeeState {
  final List<EmployeeWithDepartment> employees;

  EmployeeLoaded(this.employees);
}

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final AppDatabase database;

  EmployeeBloc(this.database) : super(EmployeeLoaded([])) {
    on<AddEmployee>((event, emit) async {
      final id = await database.into(database.employees).insert(event.employee);
      event.completer.complete(id);
      add(FetchEmployees());
    });

    on<DeleteEmployee>((event, emit) async {
      await (database.delete(database.employees)
            ..where((tbl) => tbl.id.equals(event.id)))
          .go();
      add(FetchEmployees());
    });

    on<UpdateEmployee>((event, emit) async {
      await database.update(database.employees).replace(event.employee);
      add(FetchEmployees());
    });

    on<FetchEmployees>((event, emit) async {
      final employees = await database.select(database.employees).get();
      final departments = await database.select(database.departments).get();
      final employeesWithDepartments = employees.map((employee) {
        final department = departments.firstWhere(
          (dept) => dept.id == employee.departmentId,
          orElse: () => Department(id: 0, name: 'Unknown'),
        );
        return EmployeeWithDepartment(
          employee: employee,
          departmentName: department.name,
        );
      }).toList();
      emit(EmployeeLoaded(employeesWithDepartments));
    });
  }
}
