class Todo {
  String title;
  bool done;
  String remark;
  bool star;

  Todo([String str]) {
    title = str != null ? str : '有个任务';
    remark = "";
    done = false;
    star = false;
  }

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        done = json['done'],
        remark = json['remark'],
        star = json['star'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'done': done,
        'remark': remark,
        'star': star,
      };
}
