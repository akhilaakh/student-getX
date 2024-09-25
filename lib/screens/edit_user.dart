import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/controller/student.dart';
import 'package:student_app/model/student_model.dart';
import 'package:student_app/screens/myHome_page.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key, required this.student, required this.studetKey})
      : super(key: key);
  final Student student;
  final studetKey;

  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<EditScreen> {
  final StudentController studentController = Get.put(StudentController());
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userAgeController = TextEditingController();
  final TextEditingController _userClassController = TextEditingController();
  final TextEditingController _userGenderController = TextEditingController();

  File? _image;

  @override
  void initState() {
    setState(() {
      _userNameController.text = widget.student.name;
      _userClassController.text = widget.student.age;
      _userAgeController.text = widget.student.age;
      _userGenderController.text = widget.student.gender;

      if (widget.student.imagePath != null) {
        _image = File(widget.student.imagePath!);
      } else {
        _image = null;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 33, 57),
        title: const Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Student Data",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.9),
        child: Column(
          children: [
            Row(
              children: [
                // Text(
                //   "Add New Student",
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 19,
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 35),
            CircleAvatar(
              radius: 50,
              backgroundImage: _image != null
                  ? FileImage(_image!)
                  : AssetImage('assets/AddStudent.jpg') as ImageProvider,
            ),
            ElevatedButton(
              onPressed: _getImage,
              child: const Text(
                'Pick Image',
                style: TextStyle(
                  color: const Color.fromARGB(255, 2, 33, 57),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _userNameController,
              decoration: InputDecoration(
                hintText: " Enter Full Name",
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _userAgeController,
              decoration: InputDecoration(
                hintText: " Enter Age",
                labelText: " Age",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _userClassController,
              decoration: InputDecoration(
                hintText: " Enter Class",
                labelText: " Class",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _userGenderController,
              decoration: InputDecoration(
                hintText: "Enter Gender ",
                labelText: " Gender",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 35),
            Row(
              children: [
                SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 70),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 229, 47, 34),
                  ),
                  onPressed: () {
                    _userNameController.text = "";
                    _userAgeController.text = "";
                    _userClassController.text = "";
                    _userGenderController.text = "";
                    setState(() {
                      _image = null;
                    });
                  },
                  child: Text(
                    "Clear Data",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 2, 33, 57),
                  ),
                  onPressed: () async {
                    final userName = _userNameController.text;
                    final userAge = _userAgeController.text;
                    final userClass = _userClassController.text;
                    final userGender = _userGenderController.text;

                    if (userName.isEmpty ||
                        userAge.isEmpty ||
                        userClass.isEmpty ||
                        userGender.isEmpty) {
                      _showSnackBar(
                          context, 'Please fill all fields', Colors.red);
                      return;
                    }

                    final user = Student(
                      name: userName,
                      age: userAge,
                      studentClass: userClass,
                      gender: userGender,
                      imagePath: _image?.path,
                    );

                    studentController.updateStudent(widget.studetKey, user);

                    _showSnackBar(
                        context, 'Data Saved Successfully', Colors.black);
                    Get.offAll(() => HomeScreen());
                  },
                  child: Text(
                    "Save Data",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
