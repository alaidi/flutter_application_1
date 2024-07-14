// department_bloc.dart
import 'package:employee_app/drift_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DepartmentEvent {}

class AddDepartment extends DepartmentEvent {
  final DepartmentsCompanion department;

  AddDepartment(this.department);
}

class DeleteDepartment extends DepartmentEvent {
  final int id;

  DeleteDepartment(this.id);
}

class UpdateDepartment extends DepartmentEvent {
  final DepartmentsCompanion department;

  UpdateDepartment(this.department);
}

class FetchDepartments extends DepartmentEvent {}

class DepartmentState {}

class DepartmentLoaded extends DepartmentState {
  final List<Department> departments;

  DepartmentLoaded(this.departments);
}

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  final AppDatabase database;

  DepartmentBloc(this.database) : super(DepartmentLoaded([])) {
    on<AddDepartment>((event, emit) async {
      await database.into(database.departments).insert(event.department);
      add(FetchDepartments());
    });

    on<DeleteDepartment>((event, emit) async {
      await (database.delete(database.departments)
            ..where((tbl) => tbl.id.equals(event.id)))
          .go();
      add(FetchDepartments());
    });

    on<UpdateDepartment>((event, emit) async {
      await database.update(database.departments).replace(event.department);
      add(FetchDepartments());
    });

    on<FetchDepartments>((event, emit) async {
      final departments = await database.select(database.departments).get();
      emit(DepartmentLoaded(departments));
    });
  }
}
