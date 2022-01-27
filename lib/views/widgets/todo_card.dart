import 'package:firebase_test/models/todo_model.dart';
import 'package:firebase_test/services/database.dart';
import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final String? uid;
  final TodoModel? todo;

  const TodoCard({Key? key, this.uid, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                todo!.content.toString(),
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Checkbox(
              value: todo!.done,
              onChanged: (newValue) {
                Database().updateTodo(newValue!, uid!, todo!.todoId.toString());
              },
            )
          ],
        ),
      ),
    );
  }
}
