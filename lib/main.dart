import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/department_bloc.dart';
import 'package:flutter_application_1/bloc/employee_bloc.dart';
import 'package:flutter_application_1/dashboard_page.dart';
import 'package:flutter_application_1/drift_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Import screens
import 'screen/employee/employees_page.dart';
import 'screen/department/departments_page.dart';

void main() {
  final database = AppDatabase();
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EmployeeBloc>(
          create: (context) => EmployeeBloc(database)..add(FetchEmployees()),
        ),
        BlocProvider<DepartmentBloc>(
          create: (context) =>
              DepartmentBloc(database)..add(FetchDepartments()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
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
        home: const DashboardPage(),
        // Routes for navigation
        routes: {
          EmployeesPage.routeName: (context) => const EmployeesPage(),
          DepartmentsPage.routeName: (context) => const DepartmentsPage(),
        },
      ),
    );
  }
}
