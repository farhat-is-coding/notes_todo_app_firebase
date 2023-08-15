
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/services/auth.dart';
import 'package:rive/rive.dart';
import 'dart:ui';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late RiveAnimationController _btnAnimationController;
  var _singlePress = true ;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
              child: const SizedBox(),
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            bottom: 200,
            left: 100,
            child: Image.asset("assets/Backgrounds/Spline.png"),
          ),
          const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
              child: const SizedBox(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top:80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Flawless Notes App",
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: "Poppins",
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Make Public & Private Notes that you can share with alot of features.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimButton(
                    btnAnimationController: _btnAnimationController,
                    onTap: (){
                      if(_singlePress == false){ return;}
                      _btnAnimationController.isActive = true;
                      Future.delayed(const Duration(milliseconds: 1000), () async {
                        await AuthService().anonLogin();
                        _singlePress = true;
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      });
                      _singlePress = false;
                    },
                    title: "Anonymous Login",
                    icon: const Icon(Icons.hide_source_outlined),
                  ),
                  AnimButton(
                    btnAnimationController: _btnAnimationController,
                    onTap: (){
                      if(_singlePress == false){ return;}
                      _btnAnimationController.isActive = true;
                      Future.delayed(const Duration(milliseconds: 1000), () async {
                        await AuthService().googleLogin();
                        _singlePress = true;
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      });
                      _singlePress = false;
                    },
                    title: "Google Login",
                    icon: const Icon(CupertinoIcons.greaterthan_circle_fill),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class AnimButton extends StatelessWidget {
  const AnimButton({super.key,
    required  this.btnAnimationController,
    required this.onTap,
    required this.title,
    required this.icon
  });

  final RiveAnimationController btnAnimationController;
  final VoidCallback onTap;
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onTap,
      child: SizedBox(
        height: 64,
        width: 260,
        child: Stack(
          children: [
            RiveAnimation.asset(
              "assets/RiveAssets/button.riv",
              controllers: [btnAnimationController],
            ),
            Positioned.fill(
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}