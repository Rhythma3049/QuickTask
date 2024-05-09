class TaskList {
  List<Task>? results;

  TaskList({this.results});

  TaskList.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Task>[];
      json['results'].forEach((v) {
        results!.add(Task.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Task {
  String? objectId;
  String? title;
  String? content;
  String? dueDate;
  bool? Status;
  String? createdAt;
  String? updatedAt;

  Task(
      {this.objectId,
      this.title,
      this.content,
      this.dueDate,
      this.Status,
      this.createdAt,
      this.updatedAt});

  Task.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    title = json['title'];
    content = json['content'];
    dueDate = json['dueDate'];
    Status = json['Status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['title'] = title;
    data['content'] = content;
    data['dueDate'] = dueDate;
    data['Status'] = Status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}