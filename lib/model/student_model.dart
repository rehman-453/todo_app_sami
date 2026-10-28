class StudentModel {
  final int id;
  final String name;
  final String fatherName;
  final List<String>? subjects;

  StudentModel({
    required this.id,
    required this.name,
    required this.fatherName,
    this.subjects,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'fatherName': fatherName,
    'subjects': subjects,
  };

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'],
      fatherName: json['fatherName'],
      id: json['id'],
      subjects: List<String>.from(json['subjects'] ?? []),
    );
  }
}
