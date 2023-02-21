import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../setting/setting.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Colors.black.withOpacity(.2),
            color: Colors.black,
            tabs: [
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
              if(index == 1){

                Navigator.pushNamed(context, '/my');
              }
              if(index == 2){

                Navigator.pushNamed(context, '/setting');
              }

            },
          ),
        ),
      ),
    );
  }
}
// Route _createRoute(dynamic x) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => x,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;
//
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }