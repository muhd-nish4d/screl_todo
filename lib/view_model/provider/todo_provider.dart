import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:screltodo/model/enum.dart';
import 'package:screltodo/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  //for store the todos
  List<TodoModel> completedTodos = [];
  List<TodoModel> pendingTodos = [];

  //The database name
  final String todoDbName = 'TodoDB';

  //For know the status of fetching datas
  late FetchStatus status;

  //This function take all the datas from local database
  void getAllTodos([String? searchQuery]) async {
    try {
      status = FetchStatus.loading;
      notifyListeners();
      completedTodos.clear();
      final todosFromDb = await Hive.openBox<TodoModel>(todoDbName);

      //Fetching all pending todos with the search query
      pendingTodos = todosFromDb.values.where((element) {
        return element.isCompleted == false &&
            element.title
                .toLowerCase()
                .contains(searchQuery == null ? '' : searchQuery.toLowerCase());
      }).toList();

      //Fetching all completed todos with the search query
      completedTodos = todosFromDb.values.where((element) {
        return element.isCompleted == true &&
            element.title
                .toLowerCase()
                .contains(searchQuery == null ? '' : searchQuery.toLowerCase());
      }).toList();
      notifyListeners();
      status = FetchStatus.success;
      notifyListeners();
    } catch (e) {
      status = FetchStatus.failed;
      notifyListeners();
      log(e.toString());
    }
  }

  //This function will help us for add a todo to database
  void createTodo(TodoModel todo) async {
    try {
      status = FetchStatus.loading;
      notifyListeners();
      final todoDb = await Hive.openBox<TodoModel>(todoDbName);
      await todoDb.put(todo.id, todo);
      status = FetchStatus.success;
      notifyListeners();
      log('added');
    } catch (e) {
      status = FetchStatus.failed;
      notifyListeners();
      log(e.toString());
    }
  }

  //This function will help us for edit a todo from database
  void editTodo(TodoModel todo) async {
    try {
      status = FetchStatus.loading;
      notifyListeners();
      final todoDb = await Hive.openBox<TodoModel>(todoDbName);
      await todoDb.put(todo.id, todo);
      status = FetchStatus.success;
      notifyListeners();
      log('added');
    } catch (e) {
      status = FetchStatus.failed;
      notifyListeners();
      log(e.toString());
    }
  }

  //This function will help us for delete a todo from database
  void deleteTodo(String todoId) async {
    try {
      status = FetchStatus.loading;
      notifyListeners();
      final todoDb = await Hive.openBox<TodoModel>(todoDbName);
      await todoDb.delete(todoId);
      status = FetchStatus.success;
      notifyListeners();
      log('deleted');
    } catch (e) {
      status = FetchStatus.failed;
      notifyListeners();
      log(e.toString());
    }
  }
}
