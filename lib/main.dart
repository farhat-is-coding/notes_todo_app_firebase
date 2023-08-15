import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/screens/check_screen.dart';
import 'package:notes_app/screens/home/home_screen.dart';
import 'package:notes_app/screens/login/login_screen.dart';
import 'package:notes_app/screens/setting/setting.dart';
import 'package:notes_app/screens/my_screen/my_user_note_screen/add_note/add_note_screen.dart';
import 'package:notes_app/screens/my_screen/my_screen.dart';
import 'package:notes_app/services/models.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const CheckScreen(),
          transition: Transition.zoom  
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/my',
          page: () => const MyScreen(),
          transition: Transition.zoom,
        ),
        GetPage(
          name: '/addnote',
          page: () => AddNoteScreen(myNote: Notes()),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/setting',
          page: () => const SettingScreen(),
          transition: Transition.upToDown,
        ),
      ],
    );
  }
}
