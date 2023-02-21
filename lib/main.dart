import 'package:flutter/material.dart';
import 'package:notes_app/screens/check_screen.dart';
import 'package:notes_app/screens/home/home_screen.dart';
import 'package:notes_app/screens/login/login_screen.dart';
import 'package:notes_app/screens/setting/setting.dart';
import 'package:notes_app/screens/my_screen/my_user_note_screen/add_note_screen.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      routes: {
        '/':(context) => CheckScreen(),
        '/home':(context) => HomeScreen(),
        '/my': (context) => MyScreen(),
        '/addnote': (context) => AddNoteScreen(myNote: Notes(),),
        '/login': (context) => LoginScreen(),
        '/setting': (context) =>SettingScreen(),
      },

    );
  }
}
