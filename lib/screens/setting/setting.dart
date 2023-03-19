import 'package:flutter/material.dart';
import 'package:notes_app/screens/home/todo_card.dart';
import 'package:notes_app/screens/setting/setting_button.dart';
import 'package:notes_app/services/auth.dart';

import '../home/bottom_nav_bar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(
            context, '/', (route) => false); //home screen
        return Future.value(true);
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(AuthService().user?.photoURL ?? "https://pbs.twimg.com/media/FkXvaBSX0AoAXcB.jpg",),
              radius: 50,
            ),
            SettingBtn(
              title: 'Logout',
              ontap: () async {
                await AuthService().signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
            ),
            SettingBtn(
              title: 'profile',
              ontap: () {
                Navigator.pushReplacementNamed(context, '/my');
              },
            ),
          ],
        ),
      ),
    );
  }
}
