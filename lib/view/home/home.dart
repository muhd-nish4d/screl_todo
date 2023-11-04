import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screltodo/model/enum.dart';
import 'package:screltodo/view/add_edit/add_edit.dart';
import 'package:screltodo/view/home/widgets/floating_button.dart';
import 'package:screltodo/view/home/widgets/todo_list.dart';
import 'package:screltodo/view_model/provider/todo_provider.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your Todos',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(tabs: [Text('Pending'), Text('Completed')]),
        ),
        body: Consumer<TodoProvider>(builder: (context, value, child) {
          return value.status == FetchStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSearchTextField(
                        onChanged: (value) =>
                            Provider.of<TodoProvider>(context, listen: false)
                                .getAllTodos(value),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: TabBarView(
                        children: [
                          ListTodos(todoList: value.pendingTodos),
                          ListTodos(todoList: value.completedTodos),
                        ],
                      ),
                    ),
                    Visibility(
                        visible: value.pendingTodos.length < 3 &&
                            value.completedTodos.length < 3,
                        child: const Expanded(
                            flex: 1,
                            child: Text(
                              textAlign: TextAlign.center,
                              'If you are completed swipe right\nSwipe left for edit & delete',
                              style: TextStyle(color: Colors.grey),
                            )))
                  ],
                );
        }),
        floatingActionButton: const FloatingButton(),
      ),
    );
  }
}
