import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class AppSnackbar {
  static void showSuccess( {required BuildContext context,
    required String message,

  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: Row(
        children: [
          const Icon(Icons.check_circle_outline_outlined,color: Colors.white,size: 20,),
          const SizedBox(width: 10,),
          Text(message),
        ],
      ),
      backgroundColor: Colors.green,
    ));

  }

  static void showWarning({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: Row(
        children: [
          const Icon(Icons.warning_amber_outlined,color: Colors.white,size: 20,),
          const SizedBox(width: 10,),
          Text(message),
        ],
      ),
      backgroundColor: Colors.orange,
    ));

  }

  static void showError({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: Row(
        children: [
          const Icon(Icons.cancel_outlined,color: Colors.white,size: 20,),
          const SizedBox(width: 10,),
          Text(message),
        ],
      ),
      backgroundColor: Colors.red,
    ));

  }
}
