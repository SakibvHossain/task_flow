import 'package:flutter/material.dart';

import '../../../core/enum/category.dart';
import '../../data/model/todo.dart';
import '../widgets/todo_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  //List of todos
  List<Todo> todos = [
    Todo(
        title: "Buy groceries",
        description: "Milk, Eggs, Bread",
        category: Category.important),
    Todo(
        title: "Clean house",
        description: "Vacuum living room",
        category: Category.notImportant),
    Todo(
        title: "Pay bills",
        description: "Electricity and water",
        category: Category.urgent),
    Todo(
        title: "Walk the dog",
        description: "Evening walk",
        category: Category.notUrgent),
    Todo(
        title: "Walk the dog",
        description: "Evening walk",
        category: Category.notUrgent),
    Todo(
        title: "Walk the dog",
        description: "Evening walk",
        category: Category.notUrgent),
    Todo(
        title: "Walk the dog",
        description: "Evening walk",
        category: Category.notUrgent),
    Todo(
        title: "Walk the dog",
        description: "Evening walk",
        category: Category.notUrgent),
    Todo(
        title: "Walk the dog",
        description: "Evening walk",
        category: Category.notUrgent),
  ];

  Category? selectedCategory;

  //To update todos
  void updateTodoCategory(Todo todo, Category newCategory) {
    setState(() {
      todo.category = newCategory;
    });
  }

  //Filter based on enum
  List<Todo> getFilteredTodos() {
    if (selectedCategory == null) {
      return todos;
    }
    return todos.where((todo) => todo.category == selectedCategory).toList();
  }

  String capitalize(String input) {
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
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

  Row _buildSecondRow() {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: Category.values
                  .sublist(2, 4)
                  .map((category) => Expanded(
                        child: DragTarget<Todo>(
                          onAccept: (todo) {
                            updateTodoCategory(todo, category);
                          },
                          builder: (context, candidateData, rejectedData) {
                            return Card(
                              margin: EdgeInsets.all(8),
                              color: Colors.blue,
                              child: SizedBox(
                                height: 100,
                                child: Center(
                                  child: Text(
                                    "${capitalize(category.toString().split('.').last)}\n(${todos.where((todo) => todo.category == category).length})",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ))
                  .toList(),
            );
  }

  Row _buildFirstRow() {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: Category.values
                  .sublist(0, 2)
                  .map((category) => Expanded(
                        child: DragTarget<Todo>(
                          onAccept: (todo) {
                            updateTodoCategory(todo, category);
                          },
                          builder: (context, candidateData, rejectedData) {
                            return Card(
                              margin: EdgeInsets.all(8),
                              color: Colors.blue,
                              child: SizedBox(
                                height: 100,
                                child: Center(
                                  child: Text(
                                    "${capitalize(category.toString().split('.').last)}\n(${todos.where((todo) => todo.category == category).length})",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ))
                  .toList(),
            );
  }

  Widget _buildChips() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ChoiceChip(
              label: Text("All"),
              selected: selectedCategory == null,
              onSelected: (selected) {
                setState(() {
                  selectedCategory = null;
                });
              },
            ),
            ...Category.values.map((category) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ChoiceChip(
                  label: Text(capitalize(category.toString().split('.').last)),
                  selected: selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = selected ? category : null;
                    });
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDraggableLists() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: getFilteredTodos()
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
      ),
    );
  }
}
