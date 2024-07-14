import 'package:employee_app/drift_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:employee_app/service/file_service.dart';
import 'package:drift/drift.dart' as drift;

class EmployeeEvent {}

class AddEmployee extends EmployeeEvent {
  final EmployeesCompanion employee;
  //final Completer<int> completer;

  AddEmployee(this.employee);
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
  final FileService fileService;

  EmployeeBloc(this.database, this.fileService) : super(EmployeeLoaded([])) {
    on<AddEmployee>((event, emit) async {
      final id = await database.into(database.employees).insert(event.employee);
      //event.completer.complete(id);
      if (event.employee.filePath.value != null) {
        var path =
            await fileService.saveFile(event.employee.filePath.value!, id);

        final updatedEmployee = event.employee.copyWith(
          id: drift.Value(id),
          filePath: drift.Value(path),
        );
        await database.update(database.employees).replace(updatedEmployee);
      }
      add(FetchEmployees());
    });

    on<DeleteEmployee>((event, emit) async {
      await (database.delete(database.employees)
            ..where((tbl) => tbl.id.equals(event.id)))
          .go();
      add(FetchEmployees());
    });

    on<UpdateEmployee>((event, emit) async {
      try {
        // Fetch the existing employee from the database
        final existingEmployee = await (database.select(database.employees)
              ..where((tbl) => tbl.id.equals(event.employee.id.value)))
            .getSingleOrNull();

        EmployeesCompanion employee = event.employee;

        if (existingEmployee != null) {
          // Check if the file path has changed
          if (existingEmployee.filePath != event.employee.filePath.value) {
            if (event.employee.filePath.value != null) {
              // Save the new file and update the employee's filePath
              var path = await fileService.saveFile(
                  event.employee.filePath.value!, event.employee.id.value);
              employee = event.employee.copyWith(filePath: drift.Value(path));
            }
          }
          // Update the employee in the database
          await database.update(database.employees).replace(employee);
          // Trigger fetching the updated list of employees
          add(FetchEmployees());
        } else {
          // Handle the case where the employee does not exist in the database
          print('Employee with id ${event.employee.id.value} does not exist.');
        }
      } catch (e) {
        // Handle any errors that might occur during the operation
        print('Error updating employee: $e');
      }
    });

    on<FetchEmployees>((event, emit) async {
      final employees = await database.select(database.employees).get();
      final departments = await database.select(database.departments).get();
      final employeesWithDepartments = employees.map((employee) {
        final department = departments.firstWhere(
          (dept) => dept.id == employee.departmentId,
          orElse: () => const Department(id: 0, name: 'Unknown'),
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
