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
