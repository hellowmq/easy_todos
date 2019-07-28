import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'TodoConvert.dart';
import 'TodoList.dart';

class TodoListStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/todolist.txt');
  }

  Future<TodoList> readTodoList() async {
    try {
      final file = await _localFile;
      // read the file
      String todoListJson = await file.readAsString();
      Map<String, dynamic> todoListMap = json.decode(todoListJson);

      return new TodoList.fromJson(todoListMap);
    } catch (e) {
      print("no file read");
      var todoList = new TodoList();
      return todoList;
    }
  }

  Future<File> writeTodoList(TodoList todoList) async {
    final file = await _localFile;
    // Write the file
    String jsonTodoList = json.encode(
      todoList,
      toEncodable: (todoList) {
        return todoListToMap(todoList);
      },
    );
    return file.writeAsString(jsonTodoList);
  }
}
