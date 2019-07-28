import 'package:easy_todos/todo/Todo.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  final Todo todo;

  TodoPage({Key key, @required this.todo}) : super(key: key);
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = new DateTime.now();
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.todo.title),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: widget.todo.star
                ? Icon(
                    Icons.star,
                    color: Colors.amber,
                  )
                : Icon(
                    Icons.star_border,
                    color: Colors.white,
                  ),
            onPressed: () {
              setState(() {
                widget.todo.star = !widget.todo.star;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          new Card(
            margin: const EdgeInsets.all(8.0),
            color: Colors.yellow,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 18.0, 8.0, 18.0),
                child: RaisedButton(
                  color: Colors.yellowAccent,
                  onPressed: () {},
                  child: Text(
                    widget.todo.title,
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
              ),
            ),
          ),
          new Card(
            margin: const EdgeInsets.all(8.0),
            color: Colors.lightGreen,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 18.0, 8.0, 18.0),
                child: Text(
                  dateTime.toString(),
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ),
          new Card(
            margin: const EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 18.0, 8.0, 18.0),
                child: Text(
                  widget.todo.remark == null ? "Nothing" : widget.todo.remark,
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
