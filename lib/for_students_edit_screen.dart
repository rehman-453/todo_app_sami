// import 'dart:math';

import 'package:flutter/material.dart';

import 'main.dart';

import 'package:todo_app/components/custom_text_fied.dart';
import 'package:todo_app/components/custom_buttons.dart';

class ForStudentsEditScreen extends StatefulWidget {
  final Student studentModelForEdit;
  const ForStudentsEditScreen({super.key, required this.studentModelForEdit});

  @override
  State<ForStudentsEditScreen> createState() => _ForStudentsEditScreenState();
}

class _ForStudentsEditScreenState extends State<ForStudentsEditScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();

  void saveEditedStudent() {
    String name = nameController.text;
    String fatherName = fatherNameController.text;

    if (name.isNotEmpty && fatherName.isNotEmpty) {
      final newStudent = Student(
        id: widget.studentModelForEdit.id,
        name: name,
        fatherName: fatherName,
      );
      Navigator.pop(context, newStudent);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Name and father name can't be empty"),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.black87,
        ),
      );
    }

    // final newStudent = Student(
    //   id: widget.studentModelForEdit.id,
    //   name: name,
    //   fatherName: fatherName,
    // );
    // Navigator.pop(context, newStudent);
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.studentModelForEdit.name;
    fatherNameController.text = widget.studentModelForEdit.fatherName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 50,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.studentModelForEdit.fatherName.toString(),
            style: TextStyle(fontSize: 30),
          ),
          CustomTextField(
            componentController: nameController,
            hintText: 'Enter Name',
          ),
          CustomTextField(
            componentController: fatherNameController,
            hintText: 'Enter Father Name',
          ),
          CustomButtons(
            label: 'UPDATE',
            buttonIcon: Icons.update,
            onButtonTap: () => saveEditedStudent(),
          ),
        ],
      ),
    );
  }
}
