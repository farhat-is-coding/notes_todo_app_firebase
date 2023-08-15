import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/todo_controller.dart';
import 'package:notes_app/screens/my_screen/my_user_list_screen/components/todo_header.dart';
import 'package:notes_app/screens/my_screen/my_user_list_screen/components/todo_list.dart';
import 'package:notes_app/screens/setting/setting_button.dart';


class MyListScreen extends StatelessWidget {
  const MyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        return Future.value(true);
      },
      child: Container(
        color: Colors.lightBlueAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TodoHeading(),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TodoList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> addTaskModalBottomSheet(BuildContext context) {
  final TodoController todoController = Get.put(TodoController());

  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (builder) {
      return Container(
        height: MediaQuery.of(context).size.height / 1.5,
        color: Colors.white.withOpacity(.7),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: todoController.titleController.value,
                focusNode: todoController.focusTitle.value,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SettingBtn(
              title: 'Add',
              color: Colors.lightBlueAccent,
              ontap: () {
                
                todoController.addTodo();  //pass the task
                todoController.getUserTodos();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
