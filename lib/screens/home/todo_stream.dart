
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:notes_app/screens/home/todo_card.dart';

import '../../services/firestore.dart';
import '../../services/models.dart';

class TodoRow extends StatelessWidget {
  TodoRow({Key? key}) : super(key: key);
  List<MaterialColor> colors = [
    Colors.pink, Colors.blue, Colors.cyan, Colors.blueGrey,
    Colors.deepPurple,
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Todo>>(
      future: FirestoreService().getAllTodos(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> todoList = [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Latest Todos",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
              ),
            ),
          ];
          var todos = snapshot.data;
          int idx= 0;
          for (var todo in todos!) {
            todoList.add(TodoCard(
              task: todo.task,
              taskid: todo.taskid,
              checked: todo.isChecked,
              color: colors[idx],
            ));
            todoList.add(
              SizedBox(height: 10),
            );
            idx = (idx+1)%colors.length;
          }
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                delay: Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: SlideAnimation(
                    child: todoList[index],
                  ),
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.blueAccent,
          ),
        );
      },
    );
  }
}
