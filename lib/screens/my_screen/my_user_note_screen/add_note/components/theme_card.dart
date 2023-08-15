import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/note_controller.dart';

class ThemeCard extends StatefulWidget {
  ThemeCard({required this.textColor, required this.onTap});
  Color textColor;
  VoidCallback onTap;

  @override
  State<ThemeCard> createState() => _ThemeCardState();
}

class _ThemeCardState extends State<ThemeCard> {
  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(6.0),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOutCubic,
            width: MediaQuery.of(context).size.width / 2.3,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: noteController.textColor.value == widget.textColor
                  ? Border.all(color: widget.textColor, width: 5)
                  : null,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              gradient: LinearGradient(
                colors: [
                  widget.textColor.withOpacity(.4),
                  widget.textColor.withOpacity(.4)
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "YOLO",
                    style: TextStyle(
                      color: widget.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'wheezy',
                        style: TextStyle(
                            color: widget.textColor.withOpacity(.9),
                            fontSize: 25),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
