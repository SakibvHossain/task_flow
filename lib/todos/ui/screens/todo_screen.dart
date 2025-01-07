import 'package:flutter/material.dart';

import '../../../core/enum/category.dart';
import '../../data/controller/todo_controller.dart';
import '../../data/model/todo.dart';
import '../widgets/todo_list.dart';
import 'package:get/get.dart';


class TodoScreen extends StatelessWidget {
  TodoScreen({super.key});

  final TodoController controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          'Todo App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // Top Section: Two Rows of Cards
          Column(
            children: [
              _buildFirstRow(),
              _buildSecondRow(),
            ],
          ),

          // Middle Section: Chips for Filtering
          _buildChips(),

          // Draggable list
          _buildDraggableLists(),
        ],
      ),
    );
  }

  Widget _buildFirstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: Category.values
          .sublist(0, 2)
          .map((category) => Expanded(
        child: DragTarget<Todo>(
          onAccept: (todo) {
            controller.updateTodoCategory(todo, category);
          },
          builder: (context, candidateData, rejectedData) {
            return Obx(() => Card(
              margin: const EdgeInsets.all(8),
              color: Colors.blue,
              child: SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    "${controller.capitalize(category.toString().split('.').last)}\n(${controller.todos.where((todo) => todo.category == category).length})",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ));
          },
        ),
      ))
          .toList(),
    );
  }

  Widget _buildSecondRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: Category.values
          .sublist(2, 4)
          .map((category) => Expanded(
        child: DragTarget<Todo>(
          onAccept: (todo) {
            controller.updateTodoCategory(todo, category);
          },
          builder: (context, candidateData, rejectedData) {
            return Obx(() => Card(
              margin: const EdgeInsets.all(8),
              color: Colors.blue,
              child: SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    "${controller.capitalize(category.toString().split('.').last)}\n(${controller.todos.where((todo) => todo.category == category).length})",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ));
          },
        ),
      ))
          .toList(),
    );
  }

  Widget _buildChips() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ChoiceChip(
              label: const Text("All"),
              selected: controller.selectedCategory.value == null,
              onSelected: (selected) {
                controller.selectedCategory.value = null;
              },
            ),
            ...Category.values.map((category) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ChoiceChip(
                  label: Text(controller.capitalize(
                      category.toString().split('.').last)),
                  selected: controller.selectedCategory.value == category,
                  onSelected: (selected) {
                    controller.selectedCategory.value =
                    selected ? category : null;
                  },
                ),
              );
            }).toList(),
          ],
        ),
      )),
    );
  }

  Widget _buildDraggableLists() {
    return Expanded(
      child: Obx(() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: controller.filteredTodos
              .map(
                (todo) => Draggable<Todo>(
              data: todo,
              feedback: Material(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(todo.title),
                  ),
                ),
              ),
              childWhenDragging: Opacity(
                opacity: 0.5,
                child: TodoList(
                    title: todo.title, description: todo.description),
              ),
              child: TodoList(
                  title: todo.title, description: todo.description),
            ),
          )
              .toList(),
        ),
      )),
    );
  }
}

