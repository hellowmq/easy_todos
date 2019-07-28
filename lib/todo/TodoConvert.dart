import 'dart:convert';

import 'TodoList.dart';

Map<String, dynamic> todoListToMap(TodoList todoList) {
  Map<String, dynamic> todoListMap = new Map<String, dynamic>();
  todoList.todoList.forEach((todo) {
    String todoJson = json.encode(todo);
    todoListMap[todoList.todoList.indexOf(todo).toString()] = todoJson;
  });
  return todoListMap;
}
