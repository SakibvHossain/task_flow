import 'package:flutter/material.dart';
import 'package:testing/todos/ui/screens/todo_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TodoScreen(),
    );
  }
}
