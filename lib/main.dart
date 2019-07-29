import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'bean/Data.dart';
import 'storage/todo_list_storage.dart';

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

class TodoPage extends StatefulWidget {
  final TodoListStorage storage;

  TodoPage({Key key, @required this.storage}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TodoList _todoList;
  Color color = Colors.white;

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
      backgroundColor: color,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: ListView.builder(
          itemCount: _todoList.todoList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              child: Card(
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
              ),
              key: new Key(DateTime.now().toString() + index.toString()),
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
            );
          },
        ),
        onVerticalDragStart: (details) {
          print("onVerticalDragStart" + details.toString());
        },
        onVerticalDragDown: (details) {
          setState(() {
            int colorValue =
                (details.globalPosition.dy / 720 * 256 % 256).floor();
            color = Color.fromARGB(
                255, colorValue, 256 - colorValue, (colorValue - 128).abs());

            print(colorValue);
          });
          print("onVerticalDragDown" + details.toString());
        },
        onVerticalDragCancel: () {
          print("onVerticalDragCancel");
          return null;
        },
        onVerticalDragUpdate: (details) {
          print("onVerticalDragUpdate" + details.toString());
        },
        onVerticalDragEnd: (details) {
          print("onVerticalDragEnd" + details.toString());
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
