import 'dart:convert';
// import 'dart:math';

import 'package:get_storage/get_storage.dart';
import 'package:todo_app/model/student_model.dart';
import 'package:todo_app/services/local_storage/local_storage_keys.dart';

List<StudentModel> listOfStudents = _loadStudents();

List<StudentModel> _loadStudents() {
  final String? saved = GetStorage().read<String>(
    LocalStorageKeys.studentListKey,
  );
  if (saved == null) return _sampleStudents();
  return (jsonDecode(saved) as List)
      .map((e) => StudentModel.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList();
}

List<StudentModel> _sampleStudents() => <StudentModel>[
  // StudentModel(
  //   id: Random().nextInt(1000000),
  //   name: "name1",
  //   fatherName: "fatherName1",
  // ),
  // StudentModel(
  //   id: Random().nextInt(1000000),
  //   name: "name2",
  //   fatherName: "fatherName2",
  // ),
  // StudentModel(
  //   id: Random().nextInt(1000000),
  //   name: "name3",
  //   fatherName: "fatherName3",
  // ),
];

Future<void> saveStudents() {
  return GetStorage().write(
    LocalStorageKeys.studentListKey,
    jsonEncode(listOfStudents.map((e) => e.toJson()).toList()),
  );
}
