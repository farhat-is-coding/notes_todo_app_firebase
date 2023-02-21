// ignore_for_file: prefer_const_constructors

import 'dart:developer' as d;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:notes_app/screens/home/todo_card.dart';
import 'package:notes_app/screens/setting/setting_button.dart';
import 'package:notes_app/services/auth.dart';
import 'package:notes_app/services/firestore.dart';

import '../../../services/models.dart';
import '../../../shared/error.dart';
import '../../../shared/loading.dart';



class MyListScreen extends StatelessWidget {
  MyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
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
                borderRadius: BorderRadius.only(
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



class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('todo')
          .where("uid", isEqualTo: AuthService().user?.uid)
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("");
        } else if (snapshot.hasError) {
          d.log(snapshot.error.toString());
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var todolist = snapshot.data!.docs;
          List<Widget> tdlist = [];

          for (var todo in todolist) {
            var ischecked = todo['isChecked'] as bool;
            var task = todo['task'] ?? "";
            var taskid = todo['taskid'] ?? "";

            tdlist.add(
              GestureDetector(
                onLongPress: (){
                  FirestoreService().deleteTodo(taskid);
                },
                child: TodoCard(
                  task: task,
                  checked: ischecked,
                  taskid: taskid,
                ),
              ),
            );
          }
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tdlist.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: tdlist[index],
                  ),
                ),
              );
            },
          );
        } else {
          return const Text('No todo found in Firestore. Check database');
        }
      },
    );
  }
}


class TodoHeading extends StatelessWidget {
  const TodoHeading({
    Key? key,
  }) : super(key: key);

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
          Text(
            "Todo List",
            style: TextStyle(
                fontSize: 55, color: Colors.white, fontWeight: FontWeight.w900),
          ),
          Text(
            "x tasks",
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> addTaskModalBottomSheet(BuildContext context) {
  String task = "";
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
                onChanged: (s) {
                  task = s;
                },
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),

              ),
            ),
            SettingBtn(
              title: 'Add',
              color: Colors.lightBlueAccent,
              ontap: () {
                FirestoreService().addTodo(task); //pass the task
                Navigator.pop(context);
              },
            ),

          ],
        ),
      );
    },
  );
}