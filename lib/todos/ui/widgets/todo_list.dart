import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
      ),
      subtitle: Text(
        description.split('\n').first, // This is called text sanitization or line truncation
        overflow: TextOverflow.ellipsis,
        maxLines: 1, // Limit to a single line
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
