import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:todo_app/main.dart';
import 'package:todo_app/components/custom_text_fied.dart';
import 'package:todo_app/components/custom_buttons.dart';
import 'package:todo_app/model/student_model.dart';
import 'package:todo_app/utils/global.dart';

class ForStudentsAddStudent extends StatefulWidget {
  const ForStudentsAddStudent({super.key});

  @override
  State<ForStudentsAddStudent> createState() => _ForStudentsAddStudentState();
}

class _ForStudentsAddStudentState extends State<ForStudentsAddStudent> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();

  void saveStudent() async {
    String name = nameController.text;
    String fatherName = fatherNameController.text;

    if (name.isNotEmpty && fatherName.isNotEmpty) {
      final newStudent = StudentModel(
        id: Random().nextInt(1000000),
        name: name,
        fatherName: fatherName,
      );
      // await addStudent(name, fatherName);
      await saveStudents();

      if (!mounted) return;
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
  }

  // void saveStudent() {
  //   String name = nameController.text;
  //   String fatherName = fatherNameController.text;

  //   if (name.isNotEmpty && fatherName.isNotEmpty) {
  //     final newStudent = StudentModel(
  //       id: Random().nextInt(1000000),
  //       name: name,
  //       fatherName: fatherName,
  //     );
  //     Navigator.pop(context, newStudent);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: const Text("Name and father name can't be empty"),
  //         behavior: SnackBarBehavior.floating,
  //         duration: const Duration(seconds: 2),
  //         backgroundColor: Colors.black87,
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 50,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            componentController: nameController,
            hintText: 'Enter Name',
          ),
          CustomTextField(
            componentController: fatherNameController,
            hintText: 'Enter Father Name',
          ),
          // CustomButtons(label: 'Add'),
          CustomButtons(
            label: 'Add',
            buttonIcon: Icons.add,
            onButtonTap: () => saveStudent(),
          ),
        ],
      ),
    );
  }
}
