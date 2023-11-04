import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final DateTime dueDate;
  @HiveField(4)
  final bool isCompleted;

  TodoModel(this.description,
      {required this.id,
      required this.title,
      required this.dueDate,
      required this.isCompleted});

  // factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
  //       id: json["id"],
  //       title: json["title"],
  //       dueDate: json["dueDate"],
  //       isCompleted: json["isCompleted"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "title": title,
  //       "dueDate": dueDate,
  //       "isCompleted": isCompleted,
  //     };
}
