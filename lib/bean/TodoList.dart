import 'dart:convert';

import 'Todo.dart';

class TodoList {
  List<Todo> todoList;

  TodoList() {
    todoList = List<Todo>();
  }

  TodoList.fromJson(Map<String, dynamic> jsonMap) {
    todoList.clear();
    jsonMap.forEach((index, todoJson) {
      Map todoMap = json.decode(todoJson);
      todoList.insert(int.parse(index), new Todo.fromJson(todoMap));
    });
  }

  static Map<String, dynamic> todoListToMap(TodoList todoList) {
    Map<String, dynamic> todoListMap = new Map<String, dynamic>();
    todoList.todoList.forEach((todo) {
      String todoJson = json.encode(todo);
      todoListMap[todoList.todoList.indexOf(todo).toString()] = todoJson;
    });
    return todoListMap;
  }
}
