import 'package:flutter/material.dart';
import 'package:notes_app/screens/my_screen/my_user_list_screen/my_list.dart';
import 'package:notes_app/screens/my_screen/my_user_note_screen/my_notes.dart';
import './my_user_list_screen/my_list.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  int _currentIndex = 0;

  final _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.star, color: Colors.black.withOpacity(.7)),
      label: "Notes",

    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add, color: Colors.blueAccent.shade200, size: 30,),
      label: "Todos",

    )
  ];

  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //new screen to add a note
          if (_currentIndex == 0) {
            Navigator.pushNamed(context, '/addnote');
          } else {
            addTaskModalBottomSheet(context);
          }
        },
        child: _currentIndex == 0
            ? Icon(
                Icons.star,
                color: Colors.black,
              )
            : Icon(Icons.add, color: Colors.lightBlueAccent, size: 40),
        backgroundColor: Colors.white,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        children: [
          MyNotesScreen(),
          MyListScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _bottomNavigationBarItems,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 100), curve: Curves.easeIn);
        },
        //type: BottomNavigationBarType.fixed,
      ),
    );
  }
}


