import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/department_bloc.dart';
import 'package:flutter_application_1/drift_database.dart';
import 'package:flutter_application_1/screen/department/edit_department_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_department_page.dart';

class DepartmentsPage extends StatefulWidget {
  const DepartmentsPage({super.key});
  static const routeName = '/departments';
  @override
  _DepartmentsPageState createState() => _DepartmentsPageState();
}

class _DepartmentsPageState extends State<DepartmentsPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<DepartmentBloc, DepartmentState>(
              builder: (context, state) {
                if (state is DepartmentLoaded) {
                  final filteredDepartments = state.departments
                      .where((department) => department.name
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase()))
                      .toList();
                  return ListView.builder(
                    itemCount: filteredDepartments.length,
                    itemBuilder: (context, index) {
                      final department = filteredDepartments[index];
                      return Container(
                        color: index % 2 == 0 ? Colors.grey[200] : Colors.white,
                        child: ListTile(
                          title: Text(department.name),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditDepartmentPage(
                                          department: department),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  context
                                      .read<DepartmentBloc>()
                                      .add(DeleteDepartment(department.id));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddDepartmentPage()),
                );
              },
              child: const Text('Add Department'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                final departmentBloc = context.read<DepartmentBloc>();
                for (int i = 0; i < 1000; i++) {
                  final department =
                      DepartmentsCompanion.insert(name: 'Department $i');
                  departmentBloc.add(AddDepartment(department));
                }

                // Show a confirmation message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('1000 departments added')),
                );
              },
              child: const Text('Add 1000 Departments'),
            ),
          ),
        ],
      ),
    );
  }
}
