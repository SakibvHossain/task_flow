import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing/todos/ui/screens/splash_screen.dart';


void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}