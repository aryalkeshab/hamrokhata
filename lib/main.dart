import 'package:flutter/material.dart';
import 'package:hamrokhata/Screens/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hamro Khata',
        theme: ThemeData(
         
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen());
  }
}
