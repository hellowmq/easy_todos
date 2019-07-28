import 'dart:async';
import 'dart:io';

import 'package:easy_todos/todo/Todo.dart';
import 'package:easy_todos/todo/TodoList.dart';
import 'package:easy_todos/todo/TodoListStorage.dart';
import 'package:flutter/material.dart';

import 'DrawerPage.dart';
import 'TodoPage.dart';

class HomePage extends StatefulWidget {
  final TodoListStorage storage;

  HomePage({Key key, @required this.storage}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Future<File> _addTodo([String title]) async {
    setState(() {
      if (title == "") title = "未命名任务";
      _todoList.todoList.add(Todo(title));
    });

    return widget.storage.writeTodoList(_todoList);
  }

  Future<File> _deleteTodo(int index) async {
    setState(() {
      _todoList.todoList.removeAt(index);
    });

    return widget.storage.writeTodoList(_todoList);
  }

  Future<File> _changeTodoDone(int index) async {
    setState(() {
      _todoList.todoList[index].done = !_todoList.todoList[index].done;
    });

    return widget.storage.writeTodoList(_todoList);
  }

  Future<File> _changeTodoStar(int index) async {
    setState(() {
      _todoList.todoList[index].star = !_todoList.todoList[index].star;
    });

    return widget.storage.writeTodoList(_todoList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('毛圈任务'),
      ),
      body: new ListView.builder(
        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
        itemCount: _todoList != null ? _todoList.todoList.length : 0,
        itemBuilder: (context, pageIndex) {
          int index = pageIndex;
          return new Card(
            color: Colors.white70,
            child: new Padding(
              padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
              child: new ListTile(
                title: new Text(
                  _todoList.todoList[index].title,
                  style: TextStyle(
                      fontSize: 18.0,
                      decoration: _todoList.todoList[index].done
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                leading: new Checkbox(
                  value: _todoList.todoList[index].done,
                  onChanged: (value) {
                    _changeTodoDone(index);
                  },
                ),
                trailing: new IconButton(
                  icon: _todoList.todoList[index].star
                      ? Icon(
                          Icons.star,
                          color: Colors.amber,
                        )
                      : Icon(
                          Icons.star_border,
                          color: Colors.black26,
                        ),
                  onPressed: () {
                    _changeTodoStar(index);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TodoPage(
                            todo: _todoList.todoList[index],
                          ),
                    ),
                  );
                },
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return new AlertDialog(
                          title: Text("WARNING"),
                          content: new SingleChildScrollView(
                            child: new ListBody(
                              children: <Widget>[
                                new Text("Do you want to DELETE this task?"),
                                new Text("It will be DELETE permanently. "),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            new FlatButton(
                                onPressed: () {
                                  _deleteTodo(index);
                                  Navigator.pop(context);
                                },
                                child: Text("YES")),
                            new FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("NO")),
                          ],
                        );
                      });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              var textController = new TextEditingController(
                text: "",
              );
              return new AlertDialog(
                title: Text("Create a new task"),
                content: new SingleChildScrollView(
                  child: new ListBody(
                    children: <Widget>[
                      new Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                        child: new TextField(
                          maxLength: 20,
                          style: new TextStyle(
                            color: Colors.black,
                            letterSpacing: 0.8,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w400,
                          ),
                          controller: textController,
                          autofocus: true,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                    child: Text("YES"),
                    onPressed: () {
                      _addTodo(textController.text);
                      Navigator.pop(context);
                    },
                  ),
                  new FlatButton(
                    child: Text("Cancle"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Add new Task',
        child: Icon(
          Icons.add,
        ),
      ),
      drawer: new DrawerPage(),
    );
  }
}
