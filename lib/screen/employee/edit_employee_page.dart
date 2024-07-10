import 'dart:io';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/department_bloc.dart';
import 'package:flutter_application_1/bloc/employee_bloc.dart';
import 'package:flutter_application_1/drift_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class EditEmployeePage extends StatefulWidget {
  final Employee employee;

  const EditEmployeePage({super.key, required this.employee});

  @override
  _EditEmployeePageState createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _statisticalNumberController;
  late TextEditingController _rankController;
  late TextEditingController _positionController;
  late TextEditingController _subjectController;
  late TextEditingController _statusController;
  late TextEditingController _notesController;
  int? _selectedDepartmentId;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee.fullName);
    _statisticalNumberController = TextEditingController(
        text: widget.employee.statisticalNumber.toString());
    _rankController = TextEditingController(text: widget.employee.rank);
    _positionController = TextEditingController(text: widget.employee.position);
    _subjectController = TextEditingController(text: widget.employee.subject);
    _statusController = TextEditingController(text: widget.employee.status);
    _notesController = TextEditingController(text: widget.employee.notes ?? '');
    _selectedDepartmentId = widget.employee.departmentId;
    _filePath = widget.employee.filePath;
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      final file = File(result.files.single.path!);
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(file.path);
      final savedFile = await file.copy('${appDir.path}/$fileName');
      setState(() {
        _filePath = savedFile.path;
      });

      // Delete old file
      if (widget.employee.filePath != null &&
          widget.employee.filePath!.isNotEmpty) {
        final oldFile = File(widget.employee.filePath!);
        if (await oldFile.exists()) {
          await oldFile.delete();
        }
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل الموظف'),
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
                            return 'الرجاء اختيار القسم';
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
                  child: Text(_filePath == null
                      ? 'Upload File'
                      : 'File Selected: ${path.basename(_filePath!)}'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final employee = EmployeesCompanion(
                        id: drift.Value(widget.employee.id),
                        fullName: drift.Value(_nameController.text),
                        statisticalNumber: drift.Value(
                            int.parse(_statisticalNumberController.text)),
                        rank: drift.Value(_rankController.text),
                        position: drift.Value(_positionController.text),
                        departmentId: drift.Value(_selectedDepartmentId!),
                        subject: drift.Value(_subjectController.text),
                        status: drift.Value(_statusController.text),
                        notes: drift.Value(_notesController.text),
                        filePath: drift.Value(_filePath ?? ''),
                        lastUpdate: drift.Value(DateTime.now()),
                      );
                      context
                          .read<EmployeeBloc>()
                          .add(UpdateEmployee(employee));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
