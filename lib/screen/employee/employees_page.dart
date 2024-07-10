import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/employee_bloc.dart';
import 'package:flutter_application_1/drift_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_employee_page.dart';
import 'edit_employee_page.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});
  static const routeName = '/employee';

  @override
  _EmployeesPageState createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الموظفين'),
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
                labelText: 'بحث',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<EmployeeBloc, EmployeeState>(
              builder: (context, state) {
                if (state is EmployeeLoaded) {
                  final filteredEmployees = state.employees
                      .where((employeeWithDept) => employeeWithDept
                          .employee.fullName
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase()))
                      .toList();
                  return ListView.builder(
                    itemCount: filteredEmployees.length,
                    itemBuilder: (context, index) {
                      final employeeWithDept = filteredEmployees[index];
                      final employee = employeeWithDept.employee;
                      final departmentName = employeeWithDept.departmentName;

                      return Container(
                        color: index % 2 == 0 ? Colors.grey[200] : Colors.white,
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: ListTile(
                            title: Text(employee.fullName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'الرقم الاحصائي: ${employee.statisticalNumber}'),
                                Text('الرتبه: ${employee.rank}'),
                                Text('المنصب: ${employee.position}'),
                                Text('القسم: $departmentName'),
                                Text('الماده: ${employee.subject}'),
                                Text('الحاله: ${employee.status}'),
                                Text('الملاحظات: ${employee.notes ?? ''}'),
                                if (employee.filePath != null)
                                  Text('الملف: ${employee.filePath}'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditEmployeePage(
                                            employee: employee),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    context
                                        .read<EmployeeBloc>()
                                        .add(DeleteEmployee(employee.id));
                                  },
                                ),
                              ],
                            ),
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
                      builder: (context) => const AddEmployeePage()),
                );
              },
              child: const Text('إضافة موظف'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                final employeeBloc = context.read<EmployeeBloc>();
                for (int i = 0; i < 1; i++) {
                  final employee = EmployeesCompanion.insert(
                    fullName: 'موظف $i',
                    statisticalNumber: i,
                    rank: 'رتبه $i',
                    position: 'منصب $i',
                    departmentId: 1, // Replace with a valid department ID
                    subject: 'ماده $i',
                    status: 'الحاله $i',
                    notes: drift.Value('ملاحظات $i'),
                    lastUpdate: drift.Value(DateTime.now()),
                  );
                  employeeBloc.add(AddEmployee(employee));
                }

                // Show a confirmation message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('100 موظف أضيفوا')),
                );
              },
              child: const Text('إضافة 100 موظف'),
            ),
          ),
        ],
      ),
    );
  }
}
