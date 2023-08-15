import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/todo_controller.dart';

class TodoHeading extends StatelessWidget {
  TodoHeading({
    Key? key,
  }) : super(key: key);

  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, left: 40.0, bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.list,
              size: 80,
              color: Colors.lightBlueAccent.shade200,
            ),
          ),
          const Text(
            "Todo List",
            style: TextStyle(
                fontSize: 55, color: Colors.white, fontWeight: FontWeight.w900),
          ),
          Obx(
            () => Text(
              "${todoController.userTodos.length} tasks",
              style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
