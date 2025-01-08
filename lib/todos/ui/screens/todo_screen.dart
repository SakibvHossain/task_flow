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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue, // The color is set to blue
        onPressed: () => bottomSheet(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          textAlign: TextAlign.center,
          'Task App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              _buildFirstRow(),
              _buildSecondRow(),
            ],
          ),
          _buildChips(),
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
                child: GestureDetector(
                  onTap: () {
                    controller.selectedCategory.value = category;
                  },
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
                child: GestureDetector(
                  onTap: () {
                    controller.selectedCategory.value = category;
                  },
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
                      label: Text(controller
                          .capitalize(category.toString().split('.').last)),
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
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: controller.filteredTodos.length,
            itemBuilder: (context, index) {
              final todo = controller.filteredTodos[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to the details screen with a fade transition
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return FadeTransition(
                          opacity: animation,
                          child: Scaffold(
                            appBar: AppBar(
                              iconTheme:
                                  const IconThemeData(color: Colors.white),
                              title: Text(
                                todo.title,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            body: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                todo.description,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                child: Card(
                  elevation: 4.0, // Adds a slight shadow
                  margin: const EdgeInsets.symmetric(vertical: 8.0), // Adds space between cards
                  child: LongPressDraggable<Todo>(
                    data: todo,
                    feedback: Material(
                      elevation: 4.0,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            todo.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.5,
                      child: TodoList(
                        title: todo.title,
                        description: todo.description,
                      ),
                    ),
                    child: TodoList(
                      title: todo.title,
                      description: todo.description,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> bottomSheet(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final selectedCategory = controller.selectedCategory.value;

    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Add Todo",
                    style: TextStyle(color: Colors.blue, fontSize: 22),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  maxLength: 500,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<Category>(
                  value: selectedCategory,
                  items: Category.values.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(controller.capitalize(
                        category.toString().split('.').last,
                      )),
                    );
                  }).toList(),
                  onChanged: (newCategory) {
                    controller.selectedCategory.value = newCategory;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelText: "Category",
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Center(
                      child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  )),
                  onPressed: () {
                    final title = titleController.text.trim();
                    final description = descriptionController.text.trim();
                    final category = controller.selectedCategory.value;

                    if (title.isNotEmpty &&
                        description.isNotEmpty &&
                        category != null) {
                      // Add the new todo
                      controller.todos.add(Todo(
                        title: title,
                        description: description,
                        category: category,
                      ));
                      controller.todos.refresh();

                      // Close the bottom sheet
                      Navigator.pop(context);
                    } else {
                      Get.snackbar(
                        "Error",
                        "All fields are required.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
