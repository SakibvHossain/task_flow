import 'package:get/get.dart';

import 'package:get/get.dart';
import '../../../core/enum/category.dart';
import '../../data/model/todo.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;
  var selectedCategory = Rxn<Category>();

  var isExpanded = false.obs;

  void updateTodoCategory(Todo todo, Category category) {
    todo.category = category;
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
