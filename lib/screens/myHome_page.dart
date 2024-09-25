import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/controller/checksearch.dart';
import 'package:student_app/controller/search.dart';
import 'package:student_app/controller/student.dart';
import 'package:student_app/screens/add_dataScreen.dart';
import 'package:student_app/screens/edit_user.dart';
import 'package:student_app/screens/students_all_details.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final SearchFieldController searchFieldController =
      Get.put(SearchFieldController());
  final StudentController studentController = Get.put(StudentController());
  final CheckSearchController checkSearchController =
      Get.put(CheckSearchController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                checkSearchController.isSearch.value =
                    !checkSearchController.isSearch.value;
                searchController.text = '';
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
        backgroundColor: const Color.fromARGB(255, 2, 33, 57),
        title: const Center(
          child: Text(
            "   Student Information",
            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
          ),
        ),
      ),
      body: Obx(() {
        return Column(
          children: [
            !checkSearchController.isSearch.value
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      onChanged: (value) {
                        studentController.searchStudents(searchController.text);
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'SEARCH HERE',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
            Expanded(
              child: studentController.students.isEmpty
                  ? Center(
                      child: Text('Student list is empty'),
                    )
                  : ListView.builder(
                      itemCount: checkSearchController.isSearch.value
                          ? studentController.filteredStudents.length
                          : studentController.students.length,
                      itemBuilder: (context, index) {
                        final student = checkSearchController.isSearch.value
                            ? studentController.filteredStudents[index]
                            : studentController.students[index];
                        final studentKey =
                            studentController.getStudentKey(index);

                        // Handle null keys
                        if (studentKey == null) {
                          return SizedBox.shrink();
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: const Color.fromARGB(255, 222, 211, 211),
                            child: ListTile(
                              onTap: () {
                                print('object');
                                //
                                //
                                Get.to(StudentDetails(
                                  student: student,
                                ));
                                print(studentKey);
                              },
                              title: Text(
                                student.name ?? '',
                              ),
                              subtitle: Text(
                                student.gender ?? '',
                              ),
                              leading: CircleAvatar(
                                backgroundImage: student.imagePath != null
                                    ? FileImage(
                                        File(student.imagePath!),
                                      ) as ImageProvider
                                    : AssetImage('assets/download (3).jpeg'),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.to(EditScreen(
                                        student: student,
                                        studetKey: index,
                                      ));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color:
                                          const Color.fromARGB(255, 2, 33, 57),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // studentController
                                      //     .deleteStudentByKey(studentKey);
                                      showDeleteConfirmation(context, index);
                                      if (checkSearchController
                                          .isSearch.value) {
                                        Get.off(HomeScreen());
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 127, 25, 18),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
            )
          ],
        );
      }),
      floatingActionButton: checkSearchController.isSearch.value
          ? null
          : FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 2, 33, 57),
              onPressed: () {
                Get.to(AddDataScreen());
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
    );
  }

  void onDeleteStudent(int index) {}

  Future showDeleteConfirmation(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          iconColor: Colors.white,
          title: Text('Are you sure you want to delete this student?'),
          // content: Text('This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                final studentKey = studentController.getStudentKey(index);
                if (studentKey != null) {
                  studentController.deleteStudentByKey(studentKey);
                }

                // Update the search results if applicable
                if (checkSearchController.isSearch.value) {
                  checkSearchController.isSearch.value = false;
                  searchController.text = '';
                  studentController.searchStudents('');
                } // Call your existing delete function
              },
            ),
          ],
        );
      },
    );
  }
}
