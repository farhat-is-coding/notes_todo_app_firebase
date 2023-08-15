import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/todo_controller.dart';
import 'package:notes_app/screens/home/todo/todo_card.dart';
import 'package:notes_app/services/firestore.dart';

class TodoList extends StatelessWidget {
  TodoList({Key? key}) : super(key: key);
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => todoController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: todoController.userTodos.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onLongPress: () {
                          FirestoreService().deleteTodo(
                              todoController.userTodos[index].taskid);
                        },
                        child: TodoCard(
                          task: todoController.userTodos[index].task,
                          checked: todoController.userTodos[index].isChecked,
                          taskid: todoController.userTodos[index].taskid,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
