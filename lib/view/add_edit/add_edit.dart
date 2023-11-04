import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screltodo/model/todo_model.dart';
import 'package:screltodo/view_model/provider/todo_provider.dart';
import 'package:screltodo/view_model/utils/utils.dart';

class ScreenAddOrEditTodo extends StatelessWidget {
  ScreenAddOrEditTodo({super.key, required this.isForEdit, this.todoForEdit});
  final bool isForEdit;
  final TodoModel? todoForEdit;

  ValueNotifier<String?> pickedDateNotifier = ValueNotifier(null);

  DateTime? date;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: isForEdit ? todoForEdit!.title : null);
    TextEditingController descriptionController = TextEditingController(
        text: isForEdit ? todoForEdit!.description : null);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(isForEdit ? 'Edit' : 'Add',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  IconButton(
                      onPressed: () {
                        if (!isForEdit) {
                          final todo = TodoModel(descriptionController.text,
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              title: titleController.text,
                              dueDate: date!,
                              isCompleted: false);
                          Provider.of<TodoProvider>(context, listen: false)
                              .createTodo(todo);
                        } else {
                          final todo = TodoModel(descriptionController.text,
                              id: todoForEdit!.id,
                              title: titleController.text,
                              dueDate: date ?? todoForEdit!.dueDate,
                              isCompleted: false);
                          Provider.of<TodoProvider>(context, listen: false)
                              .editTodo(todo);
                        }
                        Provider.of<TodoProvider>(context, listen: false)
                            .getAllTodos();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.check))
                ],
              ),
              TextFormField(
                controller: titleController,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                decoration: const InputDecoration(
                    hintText: 'Title', border: InputBorder.none),
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                    hintText: 'Descritpion', border: InputBorder.none),
              ),
              ValueListenableBuilder(
                  valueListenable: pickedDateNotifier,
                  builder: (context, notifierValue, child) {
                    return TextButton.icon(
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 60)));
                          if (pickedDate != null) {
                            pickedDateNotifier.value =
                                Utils.dateFormate(pickedDate);
                            date = pickedDate;
                          }
                        },
                        icon: const Icon(Icons.date_range_rounded),
                        label: Text(notifierValue ?? 'Due date'));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
