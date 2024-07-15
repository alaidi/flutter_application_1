import 'dart:io';

import 'package:employee_app/config.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:employee_app/screen/department/departments_page.dart';
import 'package:employee_app/screen/employee/employees_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:employee_app/bloc/department_bloc.dart';
import 'package:employee_app/bloc/employee_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});
  final config = Config();
  Future<void> _backupDatabase(BuildContext context) async {
    try {
      // Get the directory containing the database file
      // final dbFolder = await getApplicationDocumentsDirectory();
      // final dbFile = File(p.join(dbFolder.path, 'db.sqlite'));
      final dbFile = File(path.join(config.dataDir.path, 'db.sqlite'));
      // Open file picker to select directory for backup
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory != null) {
        final backupFile =
            File(path.join(selectedDirectory, 'db_backup.sqlite'));

        // Copy the database file to the backup location
        await dbFile.copy(backupFile.path);
        // Show message to indicate that database backup was successful
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم النسخ الاحتياطي لقاعدة البيانات بنجاح'),
            backgroundColor: Colors.green,
          ),
        );

        print('Database backup successful');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('يجب اختيار مكان الخزن'),
            backgroundColor: Colors.blueAccent,
          ),
        );
        print('No directory selected');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطا في الحفظ :$e'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error during database backup: $e');
    }
  }

  void _showPdfFolder(BuildContext context) async {
    final pdfPath = config.pdfDir.path;

    try {
      await OpenFile.open('$pdfPath\\');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطا في  $e'),
          backgroundColor: Colors.red,
        ),
      );
    }

    // Implement your logic to show PDF folder here
    print('Show PDF folder clicked');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'حفظ معلومات الموظفين',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'من تصميم: عبدالهادي محمد',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BlocBuilder<EmployeeBloc, EmployeeState>(
                    builder: (context, state) {
                      if (state is EmployeeLoaded) {
                        return _buildStatCard(
                          'الموظفين',
                          state.employees.length,
                          Icons.people,
                          context,
                          EmployeesPage.routeName,
                        );
                      }
                      return _buildLoadingCard('الموظفين', context);
                    },
                  ),
                  BlocBuilder<DepartmentBloc, DepartmentState>(
                    builder: (context, state) {
                      if (state is DepartmentLoaded) {
                        return _buildStatCard(
                          'الأقسام',
                          state.departments.length,
                          Icons.business,
                          context,
                          DepartmentsPage.routeName,
                        );
                      }
                      return _buildLoadingCard('الأقسام', context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                    'نسخ احتياطي لقاعدة البيانات',
                    Icons.backup,
                    context,
                    () => _backupDatabase(context),
                  ),
                  _buildActionButton(
                    'عرض مجلد PDF',
                    Icons.folder_open,
                    context,
                    () => _showPdfFolder(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'آخر تحديث: ${DateTime.now().toString()}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, int count, IconData icon,
      BuildContext context, String route) {
    return Expanded(
      child: MouseRegion(
        cursor:
            SystemMouseCursors.click, // Change cursor to default hand on hover
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, route);
          },
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    // Stack allows positioning icons on top of each other
                    children: [
                      Icon(icon,
                          size: 64, color: Theme.of(context).primaryColor),
                      // Show hand icon only on hover
                      const MouseRegion(
                        child: Opacity(
                          opacity: 0.0, // Initially invisible
                          child: Icon(Icons.link,
                              size: 64,
                              color: Colors.transparent), // Placeholder icon
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$count',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, BuildContext context,
      VoidCallback onPressed) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onPressed,
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 64, color: Theme.of(context).primaryColor),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingCard(String title, BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
