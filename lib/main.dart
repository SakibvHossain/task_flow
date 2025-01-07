import 'package:flutter/material.dart';
import 'package:testing/app.dart';
import 'package:testing/todos/data/model/todo.dart';
import 'package:testing/todos/ui/widgets/todo_list.dart';

import 'core/enum/category.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}