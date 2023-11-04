import 'package:hive_flutter/adapters.dart';
import 'package:screltodo/model/todo_model.dart';

class TodoDB {
  final String todoDbName = 'TodoDB';

  Future<List<TodoModel>> getAllTodo() async {
    final todos = await Hive.openBox<TodoModel>(todoDbName);
    return todos.values.toList();
  }

  Future<void> addTodo(TodoModel todo) async {
    final todoDb = await Hive.openBox<TodoModel>(todoDbName);
    await todoDb.put(todo.id, todo);
  }

  Future<void> deleteTodo(String todoId) async {
    final todoDb = await Hive.openBox<TodoModel>(todoDbName);
    await todoDb.delete(todoId);
  }

  Future<void> updateTodo(TodoModel todo) async {
    final todoDb = await Hive.openBox<TodoModel>(todoDbName);
    await todoDb.put(todo.id, todo);
  }
}
