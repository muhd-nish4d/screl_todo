import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:screltodo/model/todo_model.dart';
import 'package:screltodo/view/add_edit/add_edit.dart';
import 'package:screltodo/view_model/provider/todo_provider.dart';
import 'package:screltodo/view_model/utils/utils.dart';

class ListTodos extends StatelessWidget {
  const ListTodos({
    super.key,
    required this.todoList,
  });
  final List<TodoModel> todoList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final eachTodo = todoList[index];
        return Slidable(
          key: UniqueKey(),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),

            //If the user is completed
            dismissible: DismissiblePane(onDismissed: () {
              final todo = TodoModel(eachTodo.description,
                  id: eachTodo.id,
                  title: eachTodo.title,
                  dueDate: eachTodo.dueDate,
                  isCompleted: eachTodo.isCompleted ? false : true);
              Provider.of<TodoProvider>(context, listen: false).editTodo(todo);
              Provider.of<TodoProvider>(context, listen: false).getAllTodos();
              log(eachTodo.isCompleted.toString());
            }),
            children: [
              SlidableAction(
                onPressed: (context) {
                  // Provider.of<TodoListProvider>(context,
                  //         listen: false)
                  //     .completeTodo(eachTodo);
                },
                backgroundColor: const Color(0xFFFE4A49).withOpacity(.0),
                foregroundColor: Colors.green,
                label: eachTodo.isCompleted ? 'Uncomplete' : 'Completed',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              //For edit and delete (edit)
              SlidableAction(
                onPressed: (context) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScreenAddOrEditTodo(
                            isForEdit: true,
                            todoForEdit: eachTodo,
                          )));
                },
                backgroundColor: const Color(0xFF7BC043).withOpacity(.0),
                foregroundColor: Colors.blue,
                icon: Icons.edit,
              ),

              //For edit and delete (delete)
              SlidableAction(
                onPressed: (context) {
                  Provider.of<TodoProvider>(context, listen: false)
                      .deleteTodo(eachTodo.id);
                  Provider.of<TodoProvider>(context, listen: false)
                      .getAllTodos();
                },
                backgroundColor: const Color(0xFFFE4A49).withOpacity(.0),
                foregroundColor: Colors.red,
                icon: Icons.delete,
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              eachTodo.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(eachTodo.description ?? ''),
            trailing: Text(Utils.dateFormate(eachTodo.dueDate)),
          ),
        );
      },
      itemCount: todoList.length,
    );
  }
}
