import 'package:flutter/material.dart';
import 'package:employee_app/bloc/department_bloc.dart';
import 'package:employee_app/bloc/employee_bloc.dart';
import 'package:employee_app/dashboard_page.dart';
import 'package:employee_app/drift_database.dart';
import 'package:employee_app/service/file_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Import screens
import 'screen/employee/employees_page.dart';
import 'screen/department/departments_page.dart';

void main() {
  final database = AppDatabase();
  final fileService = FileService();
  runApp(MyApp(
    database: database,
    fileService: fileService,
  ));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;
  final FileService fileService;

  const MyApp({Key? key, required this.database, required this.fileService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EmployeeBloc>(
          create: (context) =>
              EmployeeBloc(database, fileService)..add(FetchEmployees()),
        ),
        BlocProvider<DepartmentBloc>(
          create: (context) =>
              DepartmentBloc(database)..add(FetchDepartments()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'برنامج ادارة الافراد',
        locale: const Locale('ar', ''), // Set default locale to English
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // Home page
        home: DashboardPage(),
        // Routes for navigation
        routes: {
          EmployeesPage.routeName: (context) => const EmployeesPage(),
          DepartmentsPage.routeName: (context) => const DepartmentsPage(),
        },
      ),
    );
  }
}
