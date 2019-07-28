import 'package:easy_todos/page/HomePage.dart';
import 'package:easy_todos/todo/TodoListStorage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: HomePage(storage: TodoListStorage()),
    ),
  );
}
