import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/screens/setting/setting_button.dart';
import 'package:notes_app/services/auth.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offNamedUntil('/', (route) => false);
        return Future.value(true);
      },
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                AuthService().user?.photoURL ??
                    "https://pbs.twimg.com/media/FkXvaBSX0AoAXcB.jpg",
              ),
              radius: 50,
            ),
            SettingBtn(
              title: 'Logout',
              ontap: () async {
                await AuthService().signOut();
                Get.offNamed('/');
              },
            ),
            SettingBtn(
              title: 'profile',
              ontap: () {
                Get.offNamed('/my');
              },
            ),
          ],
        ),
      ),
    );
  }
}
