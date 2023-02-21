// ignore_for_file: use_key_in_widget_constructors
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:notes_app/services/firestore.dart';


class TodoCard extends StatelessWidget {
  TodoCard({
    required this.task,
    this.checked= false,
    this.taskid = "",
    this.color = Colors.lightBlueAccent
  });

  String task, taskid;
  bool checked;
  Color color;

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
              side: BorderSide(color: Colors.white, style: BorderStyle.solid),
              value: checked,
              activeColor: Colors.lightBlueAccent.shade200,

              onChanged: (val) {
                log(val.toString());
                log(taskid);
                FirestoreService().updateTodo(taskid, val!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
