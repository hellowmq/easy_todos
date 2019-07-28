import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'bean/Data.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: TodoPage(storage: TodoListStorage()),
      theme: ThemeData(
        unselectedWidgetColor: Colors.green,
      ),
    ),
  );
}

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
      print("start readTodoList");
      final file = await _localFile;
      // read the file
      String todoListJson = await file.readAsString();
      Map<String, dynamic> todoListMap = json.decode(todoListJson);
      return new TodoList.fromJson(todoListMap);
    } catch (e) {
      var todoList = new TodoList();

      print("finish readTodoList");
      return todoList;
    }
  }

  Future<File> writeTodoList(TodoList todoList) async {
    final file = await _localFile;
    // Write the file
    String jsonTodoList = json.encode(
      todoList,
      toEncodable: (todoList) {
        return TodoList.todoListToMap(todoList);
      },
    );
    return file.writeAsString(jsonTodoList);
  }
}

class TodoPage extends StatefulWidget {
  final TodoListStorage storage;

  TodoPage({Key key, @required this.storage}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TodoList _todoList;

  @override
  void initState() {
    super.initState();
    widget.storage.readTodoList().then((TodoList todoList) {
      setState(() {
        _todoList = todoList;
      });
    });
  }

  Future<File> _addTodo() async {
    setState(() {
      _todoList.todoList.add(Todo());
    });

    return widget.storage.writeTodoList(_todoList);
  }

  Future<File> _deleteTodo(int index) async {
    setState(() {
      _todoList.todoList.removeAt(index);
    });

    return widget.storage.writeTodoList(_todoList);
  }

  Future<File> _changeTodoState(int index) async {
    setState(() {
      _todoList.todoList[index].done = !_todoList.todoList[index].done;
    });

    return widget.storage.writeTodoList(_todoList);
  }

  Future<File> _changeTodoTitle(int index, String newTitle) async {
    setState(() {
      _todoList.todoList[index].title = newTitle;
    });

    return widget.storage.writeTodoList(_todoList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('毛圈任务'),
//        actions: <Widget>[
//          new IconButton(
//              icon: new Icon(Icons.refresh),
//              onPressed: () {
//                widget.storage.readTodoList().then((TodoList todoList) {
//                  setState(() {
//                    _todoList = todoList;
//                  });
//                });
//              })
//        ],
//      ),
//      backgroundColor: Colors.black26,
      body: ListView.builder(
        itemCount: (_todoList != null && _todoList.todoList.length > 0)
            ? _todoList.todoList.length * 2
            : 0,
        itemBuilder: (context, pageIndex) {
          int index = pageIndex ~/ 2;
          return pageIndex % 2 == 0
              ? Dismissible(
                  child: ListTile(
                    title: Text(
                      _todoList.todoList[index].title,
                      style: TextStyle(
                        decoration: _todoList.todoList[index].done
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
//                        color: Colors.white,
                      ),
                    ),
                    leading: Checkbox(
                      value: _todoList.todoList[index].done,
                      onChanged: (value) {
                        _changeTodoState(index);
                      },
//                      checkColor: Colors.white,
                      activeColor: Colors.deepOrange,
                    ),
                  ),
                  key:
                      new Key(DateTime.now().toString() + pageIndex.toString()),
                  onDismissed: (direction) {
                    _deleteTodo(index);
                  },
                  confirmDismiss: (direction) async {
                    bool isConfirmed = true;
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Confirm Deletation'),
                            content: Text('All task infomation will lose.'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Yes'),
                                onPressed: () {
                                  isConfirmed = true;
                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  isConfirmed = false;
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                    return isConfirmed;
                  },
                )
              : Divider(
//                  color: Colors.white70,
                  );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Add new Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
