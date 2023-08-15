
import 'package:flutter/material.dart';
import 'package:notes_app/screens/home/home_screen.dart';

import '../services/auth.dart';
import '../shared/error.dart';
import 'login/login_screen.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream, // when user changes builder will run again
      builder: (context, snapshot) {
        //log('User ${AuthService().user}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return  Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) { // user is logged in
          return HomeScreen();
        } else { //user is null
          return const LoginScreen();
        }
      },
    );
  }
}