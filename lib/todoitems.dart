import 'package:flutter/material.dart';

import 'todo.dart';

class ToDoItems extends StatelessWidget {
  final ToDo todo;
  final onToDochanged;
  final onDeleteItem;
  const ToDoItems({
    Key? key,
    required this.todo,
    this.onToDochanged,
    this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Container(
            width: MediaQuery.of(context).size.width * .9,
            height: MediaQuery.of(context).size.height * .09,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 193, 221, 235),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Colors.black)),
            child: ListTile(
              onTap: () => onToDochanged(todo),
              shape: RoundedRectangleBorder(),
              leading: Icon(
                  todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
                  color: Colors.black),
              title: Text(
                todo.todoText!,
                style: TextStyle(
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                    fontSize: 20),
              ),
              trailing: IconButton(
                  onPressed: (() => onDeleteItem(todo.id)),
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                    size: 30,
                  )),
            ),
          ),
        ));
  }
}
