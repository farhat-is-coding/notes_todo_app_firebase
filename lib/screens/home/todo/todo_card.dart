import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/todo_controller.dart';
import 'package:notes_app/services/firestore.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.task,
    this.checked = false,
    this.taskid = "",
    this.color = Colors.lightBlueAccent,
    this.home = false,
  });

  final String task, taskid;
  final bool checked, home;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
              child: VerticalDivider(
                // thickness: 5,
                color: Colors.white70,
              ),
            ),
            const SizedBox(width: 8),
            Checkbox(
              side: const BorderSide(
                  color: Colors.white, style: BorderStyle.solid),
              value: checked,
              activeColor: Colors.lightBlueAccent.shade200,
              onChanged: home
                  ? null
                  : (val) async {
                      final TodoController todoController =
                          Get.put(TodoController());

                      log(val.toString());
                      log(taskid);
                      await FirestoreService().updateTodo(taskid, val!);
                      todoController.getUserTodos();
                    },
            ),
          ],
        ),
      ),
    );
  }
}
