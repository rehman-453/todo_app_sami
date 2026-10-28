import 'package:flutter/material.dart';
import 'package:todo_app/for_students_add_student.dart';
import 'package:todo_app/for_students_edit_screen.dart';
import 'package:todo_app/model/student_model.dart';
import 'package:todo_app/utils/global.dart';

void main() {
  runApp(const StudentApp());
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: StudentListScreen());
  }
}

// =====================================================================
// SCREEN 1: the main/home screen - shows the list of students.
// =====================================================================
class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  // Opens the second screen in "add" mode (no student passed in), then
  // waits for it to send a new Student object back.
  void addStudent(String name, String fatherName) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForStudentsAddStudent()),
    );
    listOfStudents.add(result);
    setState(() {});
  }

  void removeStudent(int index) {
    setState(() {
      listOfStudents.removeAt(index);
    });
  }

  void editStudent(StudentModel studentModelForEdit) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ForStudentsEditScreen(studentModelForEdit: studentModelForEdit),
      ),
    );
    // print("updated name \n${result.name}");

    int foundIndex = listOfStudents.indexWhere(
      (student) => student.id == result.id,
    );
    listOfStudents[foundIndex] = result;
    setState(() {});

    // print("filteredStudent ${filteredStudent.id}");
  }

  // Builds one card for a student. Tapping the card opens edit mode.
  Widget myStudentCard(StudentModel student, int index) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${student.id}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                Text(
                  student.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                // POLYMORPHISM in use: we just call getSummary() and
                // don't need to know it's a Student underneath.
                Text(student.fatherName),
              ],
            ),
            Row(
              spacing: 10,
              children: [
                InkWell(
                  onTap: () {
                    editStudent(student);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.edit),
                  ),
                ),
                InkWell(
                  onTap: () {
                    removeStudent(index);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Manager (OOP)')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // FOR LOOP: go through every Student object in the
              // list and build a card for it.
              // for (int i = 0; i < students.length; i++)
              ListView.builder(
                itemCount: listOfStudents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return myStudentCard(
                    StudentModel(
                      id: listOfStudents[index].id,
                      name: listOfStudents[index].name,
                      fatherName: listOfStudents[index].fatherName,
                    ),
                    index,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          addStudent("name", "fatherName");
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
