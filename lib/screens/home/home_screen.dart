// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:notes_app/screens/home/todo_card.dart';
import 'package:notes_app/screens/home/todo_stream.dart';
import 'package:notes_app/services/firestore.dart';
import 'package:notes_app/services/models.dart';

import 'bottom_nav_bar.dart';
import 'note_card.dart';
import 'note_stream.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                indicatorColor: Colors.black,
                tabs: [
                  Tab(icon: Icon(Icons.note_add_outlined, size:30, color: Colors.black,)),
                  Tab(icon: Icon(Icons.list_alt_outlined, size: 30, color: Colors.black,)),
                ],
              )
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: TabBarView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 18.0),
                  child: Text(
                    "Latest Notes",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
                  ),
                ),
                Expanded(
                  child: NotesRow(),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: TodoRow(),
                ),
              ],
            )
          ],
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}


