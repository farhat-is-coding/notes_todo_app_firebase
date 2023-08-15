import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/note_controller.dart';
import 'package:notes_app/screens/my_screen/my_user_note_screen/add_note/components/row_items.dart';
import '../../../../services/auth.dart';
import '../../../../services/models.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key, required this.myNote});
  final Notes myNote;
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final NoteController noteController = Get.put(NoteController());

  Future<bool> popScreen() async {
    if (noteController.focused.value == true) {
      log('back click');
      await noteController.clickBtn();
      return Future.value(false);
    } else {
      if (noteController.noteuid.value == AuthService().user?.uid ||
          noteController.noteid.value == "") {
        // noteController.getUserNotes();
        await Get.offAllNamed(
            '/my'); // Navigate to '/' and remove all previous routes
        // Get.toNamed('/my'); // Navigate to '/my'
      } else {
        // noteController.getNotes();

        await Get.offAllNamed(
            '/'); // Navigate to '/' and remove all previous routes
      }
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: popScreen,
        child: Scaffold(
          appBar: noteController.allowFullControl.value == true
              ? AppBar(
                  elevation: 0,
                  backgroundColor: noteController.bgColor,
                  leading: GestureDetector(
                    onTap: popScreen,
                    child: Icon(
                      Icons.arrow_back,
                      color: noteController.textColor.value,
                    ),
                  ),
                  title: Align(
                    alignment: Alignment.centerRight,
                    child: RowItems(),
                  ))
              : AppBar(
                  backgroundColor: noteController.textColor.value,
                ),
          backgroundColor: noteController.bgColor,
          body: Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 15.0, right: 15, bottom: 5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Insert Title",
                      hintStyle: TextStyle(
                          color: noteController.textColor.value.withOpacity(.5),
                          fontSize: 30),
                    ),
                    style: TextStyle(
                        color: noteController.textColor.value,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                    onChanged: (tit) {
                      noteController.title.value = tit;
                      noteController.focused.value = true;
                    },
                    autofocus: false,
                    focusNode: noteController.focusTitle.value,
                    controller: noteController.titleController.value,
                    enabled: noteController.allowFullControl.value == true
                        ? true
                        : false,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${noteController.datecreated.value} | ${noteController.content.value.length.toString()} characters",
                        style: TextStyle(
                          color: noteController.textColor.value.withOpacity(.6),
                          fontSize: 12,
                          fontFamily: "Poppins",
                        ),
                      ),
                      noteController.lastupdated.value != ""
                          ? Text(
                              "Last updated: ${noteController.lastupdated.value}",
                              style: TextStyle(
                                color: noteController.textColor.value
                                    .withOpacity(.6),
                                fontSize: 12,
                                fontFamily: "Poppins",
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     Text(
                  //         "${noteController.focusTitle.value.hasFocus} is title controller"),
                  //     Text(
                  //         "${noteController.focusNote.value.hasFocus} is note controller"),
                  //  Text("${noteController.focused.value.toString()}")
                  //   ],
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Insert your message",
                            hintStyle: TextStyle(
                                color: noteController.textColor.value
                                    .withOpacity(.5),
                                fontSize: 16),
                          ),
                          scrollPadding: const EdgeInsets.all(20.0),
                          keyboardType: TextInputType.multiline,
                          maxLines: 99999,
                          autofocus: false,
                          style: TextStyle(
                            color:
                                noteController.textColor.value.withOpacity(.9),
                            fontSize: 16,
                          ),
                          onChanged: (s) {
                            noteController.focused.value = true;
                            if (noteController.isRedo.value == true) {
                              noteController.isRedo.value = false;
                              return;
                            }
                            noteController.content.value = s;
                            noteController.redocontroller.value.modify(s);
                          },
                          focusNode: noteController.focusNote.value,
                          controller: noteController.noteController.value,
                          enabled: noteController.allowFullControl.value == true
                              ? true
                              : false,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
