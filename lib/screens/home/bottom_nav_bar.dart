import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:notes_app/controller/note_controller.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.7),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.black.withOpacity(.2),
            hoverColor: Colors.black.withOpacity(.2),
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            activeColor: Colors.black,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.black.withOpacity(.2),
            color: Colors.black,
            tabs: const [
              GButton(
                icon: Icons.home,
              ),
              GButton(
                icon: Icons.star_border_purple500,
              ),
              GButton(
                icon: Icons.person,
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              if (index == 1) {
                final NoteController noteController = Get.put(NoteController());
                noteController.getUserNotes();
                Get.toNamed('/my');
                // Navigator.pushNamed(context, '/my');
              }
              if (index == 2) {
                Get.toNamed('/setting');
                // Navigator.pushNamed(context, '/setting');
              }
            },
          ),
        ),
      ),
    );
  }
}
