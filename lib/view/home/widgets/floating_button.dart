import 'package:flutter/material.dart';
import 'package:screltodo/view/add_edit/add_edit.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ScreenAddOrEditTodo(isForEdit: false),
          ));
        },
        icon: const Icon(Icons.add),
        style: IconButton.styleFrom(
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
