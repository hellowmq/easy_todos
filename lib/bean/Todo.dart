class Todo {
  String title;
  bool done;
  List<SubTask> subTaskList;

  Todo({String content}) {
    title = content != null ? content : DateTime.now().toString();
    done = false;
    subTaskList = new List<SubTask>();
  }

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        done = json['done'] as bool,
        subTaskList = json['subTaskList'] as List<SubTask>;

  Map<String, dynamic> toJson() => {
        'title': title,
        'done': done.toString(),
        'subTaskList': subTaskList.map((subTask) => subTask).toList(),
      };
}

class SubTask {
  String content;
  bool done;

  SubTask({String content = 'new subTask', bool done = false}) {
    this.content = content;
    this.done = done;
  }

  SubTask.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    done = json['done'] as bool;
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'done': done as bool,
      };

  String toString() => "{'content':$content,'done':$done}";
}
