import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:employee_app/bloc/department_bloc.dart';
import 'package:employee_app/drift_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditDepartmentPage extends StatefulWidget {
  final Department department;

  const EditDepartmentPage({super.key, required this.department});

  @override
  _EditDepartmentPageState createState() => _EditDepartmentPageState();
}

class _EditDepartmentPageState extends State<EditDepartmentPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.department.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل قسم'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'الاسم'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء ادخال اسم القسم';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedDepartment = DepartmentsCompanion(
                      id: drift.Value(widget.department.id),
                      name: drift.Value(_nameController.text),
                    );
                    context
                        .read<DepartmentBloc>()
                        .add(UpdateDepartment(updatedDepartment));
                    Navigator.pop(context);
                  }
                },
                child: const Text('تحديث'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
