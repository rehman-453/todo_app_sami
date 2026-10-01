// STUDENT MANAGER APP  (the four pillars of OOP)
//
// This app is built around ONE small example so you can see all four
// OOP pillars working together in real, running code:
//
//   1. ABSTRACTION   -> the abstract class "Person" below.
//   2. INHERITANCE   -> "Student extends Person".
//   3. ENCAPSULATION -> the private "_dob" / "_fatherName" fields.
//   4. POLYMORPHISM  -> the overridden getSummary() method.
//
// Each one is explained right above the code that demonstrates it.
//
// The UI is still built the simple way you already know:
//   - Container  (a box with width, height, color, padding...)
//   - Column     (stacks things vertically)
//   - Row        (stacks things horizontally)
//   - GestureDetector (makes a Container tappable)
//   - for loops directly inside the widget list
//
// NEW this time: the app has two SCREENS. Tapping the + button
// navigates to a second screen to add (or edit) a student, and that
// screen sends the result back to the first screen.

import 'package:flutter/material.dart';
import 'package:todo_app/for_students_add_student.dart';
import 'package:todo_app/for_students_edit_screen.dart';

void main() {
  runApp(const StudentApp());
}

class Student {
  int id;
  String name;
  String fatherName;
  List<String>? subjects;

  Student({
    required this.id,
    required this.name,
    required this.fatherName,
    this.subjects,
  });
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: StudentListScreen());
  }
}

// =====================================================================
// PILLAR 1: ABSTRACTION
// =====================================================================
// "abstract class" means this class can NEVER be turned into an object
// directly (you can never write Person(...)). It only describes WHAT
// every kind of person in our app must have and must be able to do.
// It hides the "how" and only promises the "what".
// abstract class Person {
//   final String id;
//   String name;
//
//   Person({required this.id, required this.name});
//
//   // No body here on purpose - every subclass MUST provide its own.
//   String getSummary();
// }
//
// // =====================================================================
// // PILLAR 2: INHERITANCE
// // =====================================================================
// // "extends Person" means Student automatically REUSES the id and name
// // fields from Person instead of retyping them. Student only needs to
// // add what is extra: dob and fatherName.
// class Student extends Person {
//   // ===================================================================
//   // PILLAR 3: ENCAPSULATION
//   // ===================================================================
//   // Starting a field with "_" makes it PRIVATE to this file. Other
//   // screens cannot do myStudent._dob = "..." directly - they are
//   // forced to go through updateDetails() below, which is the only
//   // door in. This is encapsulation: the object controls access to its
//   // own data instead of letting anyone change it however they like.
//   String _dob;
//   String _fatherName;
//
//   String get dob => _dob;
//   String get fatherName => _fatherName;
//
//   Student({
//     required super.id,
//     required super.name,
//     required String dob,
//     required String fatherName,
//   })  : _dob = dob,
//         _fatherName = fatherName;
//
//   // The only way to change the private fields after creation.
//   void updateDetails({
//     required String name,
//     required String dob,
//     required String fatherName,
//   }) {
//     this.name = name;
//     _dob = dob;
//     _fatherName = fatherName;
//   }
//
//   // ===================================================================
//   // PILLAR 4: POLYMORPHISM
//   // ===================================================================
//   // This OVERRIDES the abstract getSummary() from Person. Anywhere in
//   // the app that calls somePerson.getSummary(), Dart automatically
//   // runs THIS version whenever somePerson is actually a Student
//   // underneath - even if the code only knows it as a "Person". That is
//   // polymorphism: the same method call, different behaviour, decided
//   // at runtime by the real (child) type of the object.
//   @override
//   String getSummary() {
//     return '$name (DOB: $_dob, Father: $_fatherName)';
//   }
// }

// =====================================================================
// SCREEN 1: the main/home screen - shows the list of students.
// =====================================================================
class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  // A LIST OF OBJECTS. We type it as List<Student>, but because Student
  // IS-A Person, every item here also counts as a Person.
  List<Student> students = [
    Student(id: 11, name: "name1", fatherName: "fatherName1"),
    Student(id: 22, name: "name2", fatherName: "fatherName2"),
    Student(id: 33, name: "name3", fatherName: "fatherName3"),
  ];

  // A simple counter used to hand out a new id to every new student.
  int nextId = 1;

  // ---------- FUNCTIONS ----------

  // Opens the second screen in "add" mode (no student passed in), then
  // waits for it to send a new Student object back.
  void addStudent(String name, String fatherName) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForStudentsAddStudent()),
    );
    students.add(result);
    setState(() {});
    // Navigator.of(context).
    // if (result != null && result is Student) {
    //   setState(() {
    //     students.add(Student(name: name, fatherName: fatherName));
    //     nextId++;
    //   });
    // }
  }

  void removeStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
  }

  void editStudent(Student studentModelForEdit) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ForStudentsEditScreen(studentModelForEdit: studentModelForEdit),
      ),
    );
    // print("updated name \n${result.name}");

    int foundIndex = students.indexWhere((student) => student.id == result.id);
    students[foundIndex] = result;
    setState(() {});

    // print("filteredStudent ${filteredStudent.id}");
  }

  // Builds one card for a student. Tapping the card opens edit mode.
  Widget myStudentCard(Student student, int index) {
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
                // Text(
                //   'ID: ${student.id}',
                //   style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                // ),
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
                itemCount: students.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return myStudentCard(
                    Student(
                      id: students[index].id,
                      name: students[index].name,
                      fatherName: students[index].fatherName,
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

      // FloatingActionButton(
      //   backgroundColor: Colors.blue,
      //   onPressed: () {
      //     students.add(Student(name: "name", fatherName: "fatherName"));
      //     setState(() {
      //
      //     });
      //   },
      // goToAddScreen,
      // child: const Icon(Icons.add, color: Colors.white),
      // ),
    );
  }
}

// =====================================================================
// SCREEN 2: add / edit screen.
// =====================================================================
// If studentToEdit is null -> we are ADDING a new student.
// If studentToEdit is NOT null -> we are EDITING that existing student.
// class AddEditStudentScreen extends StatefulWidget {
//   final int newId;
//   final Student? studentToEdit;
//
//   const AddEditStudentScreen({
//     super.key,
//     required this.newId,
//     this.studentToEdit,
//   });
//
//   @override
//   State<AddEditStudentScreen> createState() => _AddEditStudentScreenState();
// }
//
// class _AddEditStudentScreenState extends State<AddEditStudentScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   final TextEditingController fatherNameController = TextEditingController();
//
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//
//     // If we were given a student to edit, pre-fill the boxes with its
//     // current details (read through the public getters - not the
//     // private fields - which is encapsulation working as intended).
//     final Student? student = widget.studentToEdit;
//     if (student != null) {
//       nameController.text = student.name;
//       dobController.text = student.dob;
//       fatherNameController.text = student.fatherName;
//     }
//   }
//
//   // ---------- FUNCTIONS ----------
//
//   void saveStudent() {
//     String name = nameController.text;
//     String dob = dobController.text;
//     String fatherName = fatherNameController.text;
//
//     if (name == '' || dob == '' || fatherName == '') {
//       setState(() {
//         errorMessage = 'Please fill in all the fields.';
//       });
//       return;
//     }
//
//     final Student? existingStudent = widget.studentToEdit;
//
//     if (existingStudent != null) {
//       // EDIT MODE: change the existing object through its own method
//       // instead of building a brand new Student.
//       existingStudent.updateDetails(
//         name: name,
//         dob: dob,
//         fatherName: fatherName,
//       );
//       Navigator.pop(context, existingStudent);
//     } else {
//       // ADD MODE: build one new Student object.
//       final newStudent = Student(
//         id: widget.newId.toString(),
//         name: name,
//         dob: dob,
//         fatherName: fatherName,
//       );
//       Navigator.pop(context, newStudent);
//     }
//   }
//
//   // Builds one input box.
//   Widget myTextBox(String hint, TextEditingController controller) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade200,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           hintText: hint,
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isEditing = widget.studentToEdit != null;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(isEditing ? 'Edit Student' : 'Add Student'),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             myTextBox('Name', nameController),
//             myTextBox('Date of Birth (e.g. 01-01-2005)', dobController),
//             myTextBox("Father's Name", fatherNameController),
//
//             if (errorMessage != '')
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: Text(
//                   errorMessage,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//
//             GestureDetector(
//               onTap: saveStudent,
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   isEditing ? 'Save Changes' : 'Add Student',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
