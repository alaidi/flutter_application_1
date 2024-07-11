import 'dart:async';
import 'dart:io';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/department_bloc.dart';
import 'package:flutter_application_1/bloc/employee_bloc.dart';
import 'package:flutter_application_1/drift_database.dart';
import 'package:flutter_application_1/service/file_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key});

  @override
  _AddEmployeePageState createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _statisticalNumberController = TextEditingController();
  final _rankController = TextEditingController();
  final _positionController = TextEditingController();
  final _subjectController = TextEditingController();
  final _statusController = TextEditingController();
  final _notesController = TextEditingController();

  int? _selectedDepartmentId;
  String? _filePath;
  final FileService _fileService = FileService();
  Future<void> _pickFile() async {
    final filePath = await _fileService.pickFile();
    if (filePath != null) {
      setState(() {
        _filePath = filePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة موظف'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'الاسم الثلاثي'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال الاسم الثلاثي';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _statisticalNumberController,
                  decoration:
                      const InputDecoration(labelText: 'الرقم الاحصائي'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال الرقم الاحصائي';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _rankController,
                  decoration: const InputDecoration(labelText: 'الرتبه'),
                ),
                TextFormField(
                  controller: _positionController,
                  decoration: const InputDecoration(labelText: 'المنصب'),
                ),
                BlocBuilder<DepartmentBloc, DepartmentState>(
                  builder: (context, state) {
                    if (state is DepartmentLoaded) {
                      return DropdownButtonFormField<int>(
                        decoration: const InputDecoration(labelText: 'القسم'),
                        value: _selectedDepartmentId,
                        items: state.departments.map((department) {
                          return DropdownMenuItem<int>(
                            value: department.id,
                            child: Text(department.name),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedDepartmentId = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'الرجاء اختيار قسم';
                          }
                          return null;
                        },
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                TextFormField(
                  controller: _subjectController,
                  decoration: const InputDecoration(labelText: 'الماده'),
                ),
                TextFormField(
                  controller: _statusController,
                  decoration: const InputDecoration(labelText: 'الحاله'),
                ),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(labelText: 'الملاحظات'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickFile,
                  child: Text(_filePath == null ? 'رفع ملف' : 'ملف مختار'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var employee = EmployeesCompanion(
                        fullName: drift.Value(_nameController.text),
                        statisticalNumber: drift.Value(
                            int.parse(_statisticalNumberController.text)),
                        rank: drift.Value(_rankController.text),
                        position: drift.Value(_positionController.text),
                        departmentId: drift.Value(_selectedDepartmentId!),
                        subject: drift.Value(_subjectController.text),
                        status: drift.Value(_statusController.text),
                        notes: drift.Value(_notesController.text),
                        filePath: drift.Value(''),
                      );
                      final completer = Completer<int>();
                      context
                          .read<EmployeeBloc>()
                          .add(AddEmployee(employee, completer));
                      final id = await completer.future;
                      final newFileName =
                          '${id}_${DateTime.now().toIso8601String()}.pdf';

                      if (_filePath != null) {
                        final savedFilePath =
                            await _fileService.saveFile(_filePath!, id);
                        final updatedEmployee = employee.copyWith(
                            filePath: drift.Value(savedFilePath));
                        context
                            .read<EmployeeBloc>()
                            .add(UpdateEmployee(updatedEmployee));
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('إضافة موظف'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _statisticalNumberController.dispose();
    _rankController.dispose();
    _positionController.dispose();
    _subjectController.dispose();
    _statusController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
