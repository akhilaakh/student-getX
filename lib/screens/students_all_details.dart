import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/controller/student.dart';
import 'package:student_app/model/student_model.dart';

class StudentDetails extends GetView<StudentController> {
  final Student student;

  const StudentDetails({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 33, 57),
        title: const Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Student Details",
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
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: ClipOval(
                  child: SizedBox(
                    width: 220,
                    height: 220,
                    child: student.imagePath != null
                        ? Image.file(File(student.imagePath!),
                            fit: BoxFit.cover)
                        : Image.asset('assets/student11.jpg',
                            fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Card(
                color: Color.fromARGB(255, 240, 242, 243),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "User Full Details",
                      style: TextStyle(
                          fontSize: 22,
                          color: const Color.fromARGB(255, 2, 33, 57)),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          const Text(
                            "Name:",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 2, 33, 57),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            student.name ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          const Text(
                            "Age:",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 2, 33, 57),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            student.age.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          const Text(
                            "Student Class:",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 2, 33, 57),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            student.studentClass,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          const Text(
                            "Gender:",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 2, 33, 57),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            student.gender.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
