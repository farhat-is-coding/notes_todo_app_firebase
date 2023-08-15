import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/note_controller.dart';
import 'package:notes_app/screens/my_screen/my_user_note_screen/add_note/components/theme_card.dart';

class RowItems extends StatelessWidget {
  RowItems({super.key});
  final NoteController noteController = Get.put(NoteController());

  List<dynamic> colors = [
    Colors.black.withOpacity(.7),
    Colors.pinkAccent.shade100,
    Colors.cyan.shade400,
    Colors.deepPurple.shade400,
    Colors.grey.shade800,
    Colors.lightBlue.shade800,
    Colors.redAccent.shade100,
    Colors.orangeAccent.shade200,
    Colors.greenAccent.shade200
  ];

  Future<dynamic> ThemesModalBottomSheet(context) {
    return showModalBottomSheet(
      context:context,
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).size.height / 3.8,
          color: noteController.bgColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Row(
                  children: colors
                      .map(
                        (color) => ThemeCard(
                          textColor: color,
                          onTap: () {
                            noteController.updateColor(color);
                          },
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        );
      },
    );
  }

  List<Widget> _getActiveItems() {
    return noteController.focusNote.value.hasFocus == true
        ? [
            GestureDetector(
              onTap: noteController.undoBtn,
              child: Icon(Icons.undo, color: noteController.textColor.value),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: noteController.redoBtn,
              child: Icon(Icons.redo, color: noteController.textColor.value),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: noteController.clickBtn,
              child: Icon(Icons.check, color: noteController.textColor.value),
            ),
            const SizedBox(
              width: 10,
            ),
          ]
        : [
            GestureDetector(
              onTap: noteController.clickBtn,
              child: Icon(Icons.check, color: noteController.textColor.value),
            ),
            const SizedBox(
              width: 10,
            ),
          ];
  }

  List<Widget> _getInactiveItems(context) {
    return [
      GestureDetector(
        child: Icon(
          Icons.tag_faces,
          color: noteController.textColor.value,
        ),
        onTap: () {
          ThemesModalBottomSheet(context);
        },
      ),
      const SizedBox(
        width: 20,
      ),
      Icon(Icons.star, color: noteController.textColor.value),
      const SizedBox(
        width: 20,
      ),
      noteController.isPublic.value == true
          ? GestureDetector(
              onTap: () {
                // call a method in controller to update the note privacy
                noteController.setPrivacy(false);
                // setState(() {
                //   isPublic = false;
                // });
              },
              child: Icon(
                Icons.public,
                color: noteController.textColor.value,
              ),
            )
          : GestureDetector(
              onTap: () {
                noteController.setPrivacy(true);
              },
              child: Icon(
                Icons.public_off,
                color: noteController.textColor.value,
              ),
            )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: noteController.focused.value == true
              ? _getActiveItems()
              : _getInactiveItems(context),
        ),
      ),
    );
  }
}
