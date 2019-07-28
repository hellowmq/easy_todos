import 'dart:convert';

import 'package:easy_todos/todo/Todo.dart';

class TodoList {
  List<Todo> todoList;

  TodoList() {
    todoList = List<Todo>();
  }

  TodoList.fromJson(Map<String, dynamic> jsonMap) {
    todoList = new List<Todo>();
    jsonMap.forEach((index, todoJson) {
      Map todoMap = json.decode(todoJson);
      todoList.insert(int.parse(index), new Todo.fromJson(todoMap));
    });
  }
}
