import '../../../core/enum/category.dart';

class Todo {
  String title;
  String description;
  Category category;

  Todo({
    required this.title,
    required this.description,
    required this.category,
  });
}