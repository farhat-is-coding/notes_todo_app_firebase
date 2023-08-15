import 'package:flutter/material.dart';

class SettingBtn extends StatelessWidget {
  const SettingBtn({
    required this.title,
    required this.ontap,
    this.iconsSrc = "assets/icons/yolo.jpg",
    this.color = Colors.deepPurple
  });

  final iconsSrc;
  final String title;
  final VoidCallback ontap;
  final Color color;

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
                child: VerticalDivider(
                  // thickness: 5,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(backgroundImage: AssetImage(iconsSrc),)
            ],
          ),
        ),
      ),
    );
  }
}