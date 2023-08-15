import 'package:flutter/material.dart';
import 'package:notes_app/screens/home/todo/todo_list.dart';
import 'bottom_nav_bar.dart';
import 'notes/note_grid.dart';

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
          flexibleSpace: const Column(
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
                const Padding(
                  padding: EdgeInsets.only(top: 5, left: 18.0),
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
                        crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 5, left: 18.0),
                  child: Text(
                    "Latest Todos",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
                  ),
                ),
                Expanded(
                  child: TodoRow(),
                ),
              ],
            )
          ],
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}


