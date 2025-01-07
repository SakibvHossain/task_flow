import 'package:get/get.dart';

import 'package:get/get.dart';
import '../../../core/enum/category.dart';
import '../../data/model/todo.dart';

class TodoController extends GetxController {
  // List of todos
  var todos = <Todo>[
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
  ].obs;

  // Selected category
  var selectedCategory = Rxn<Category>();

  void updateTodoCategory(Todo todo, Category newCategory) {
    todo.category = newCategory;
    todos.refresh();
  }

  List<Todo> get filteredTodos {
    if (selectedCategory.value == null) {
      return todos;
    }
    return todos.where((todo) => todo.category == selectedCategory.value).toList();
  }

  String capitalize(String input) {
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }
}
