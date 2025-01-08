import 'package:flutter/material.dart';
import 'package:testing/todos/data/controller/todo_controller.dart';
import 'package:get/get.dart';

class TodoList extends StatelessWidget {
  TodoList({super.key, required this.title, required this.description});

  final String title;
  final String description;

  final TodoController controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
      ),
      subtitle: Obx(
          () => controller.isExpanded.value
            ? SizedBox()
            : Text(
                description
                    .split('\n')
                    .first, // Display only the first line in the subtitle
                overflow: TextOverflow.ellipsis,
                maxLines: 1, // Limit subtitle to a single line
                style: const TextStyle(fontSize: 14),
              ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              description, // Show the full description when expanded
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
      onExpansionChanged: (bool changedValue) {
        controller.isExpanded.value = changedValue;
      },
    );
  }
}
