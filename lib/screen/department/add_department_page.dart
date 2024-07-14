import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:employee_app/bloc/department_bloc.dart';
import 'package:employee_app/drift_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDepartmentPage extends StatefulWidget {
  const AddDepartmentPage({super.key});

  @override
  _AddDepartmentPageState createState() => _AddDepartmentPageState();
}

class _AddDepartmentPageState extends State<AddDepartmentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  // final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اضافة قسم'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'اسم القسم'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء كتابة اسم القسم';
                  }
                  return null;
                },
              ),
              // TextFormField(
              //   controller: _descriptionController,
              //   decoration: const InputDecoration(labelText: 'Description'),
              // ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final department = DepartmentsCompanion(
                      name: Value(_nameController.text),
                      // description: Value(_descriptionController.text),
                    );
                    context
                        .read<DepartmentBloc>()
                        .add(AddDepartment(department));
                    Navigator.pop(context);
                  }
                },
                child: const Text('حفظ'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    // _descriptionController.dispose();
    super.dispose();
  }
}
