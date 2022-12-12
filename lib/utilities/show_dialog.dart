import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'There was a problem',
          style: TextStyle(color: Colors.red),
        ),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
