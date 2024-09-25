import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFieldController extends GetxController {
  final TextEditingController textEditingController = TextEditingController();

  var text = ''.obs;
  @override
  void onInit() {
    super.onInit();
    // Listen to changes in textEditingController and update the 'text' observable
    textEditingController.addListener(updateText);
  }

  void updateText() {
    if (textEditingController.text != text.value) {
      text.value = textEditingController.text;
    }
  }

  @override
  void onClose() {
    textEditingController.removeListener(updateText); // Remove listener
    textEditingController.dispose(); // Dispose TextEditingController
    super.onClose();
  }
}
