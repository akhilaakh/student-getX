import 'dart:math';

import 'package:get/get.dart';
import 'package:student_app/model/student_model.dart';

class ProfilController extends GetxController {
  var student =
      Student(name: '', age: '', studentClass: '', gender: '', imagePath: '')
          .obs;
  void updataProfile(
      {required String name,
      required String age,
      required String studentClass,
      required String gender,
      required String imagePath}) {}
  void updateProfileImage(String imagePath) {
    student.value.imagePath = imagePath;
    log('Image Updata succesfull' as num);
  }
}
