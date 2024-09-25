import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:student_app/model/student_model.dart';

class StudentController extends GetxController {
  var students = <Student>[].obs;
  var filteredStudents = <Student>[].obs;

  @override
  void onInit() {
    loadStudents();
    super.onInit();
  }

  void loadStudents() {
    var box = Hive.box<Student>('students');
    students.value = box.values.toList();
  }

  dynamic getStudentKey(int index) {
    var box = Hive.box<Student>('students');
    if (index < 0 || index >= box.length) {
      print("Index out of range: $index");
      return null; // Handle out-of-range index
    }
    return box.keyAt(index); // Return the key for the specific index
  }

  void addStudent(Student student) {
    var box = Hive.box<Student>('students');
    box.add(student);
    students.add(student);
  }

  void updateStudent(int index, Student student) {
    var box = Hive.box<Student>('students');
    box.putAt(index, student);
  }

  Student? getStudentFromKey(int key) {
    var box = Hive.box<Student>('students');
    Student? student = box.getAt(key);
    return student;
  }

  void deleteStudentByKey(dynamic key) {
    var box = Hive.box<Student>('students');
    print('Attempting to delete student with key: $key');

    if (box.containsKey(key)) {
      box.delete(key);
      print("Student with key: $key deleted successfully");
    } else {
      print("Key: $key not found in the box");
    }

    loadStudents(); // Reload students to update the list
  }

  void searchStudents(String query) {
    if (query.isEmpty) {
      filteredStudents
          .assignAll(students); // Show all students if query is empty
    } else {
      var lowercaseQuery = query.toLowerCase();
      var result = students.where(
          (student) => student.name.toLowerCase().contains(lowercaseQuery));
      filteredStudents.assignAll(result.toList()); // Filter students by name
    }
  }
}
