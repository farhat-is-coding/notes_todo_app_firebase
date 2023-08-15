import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/note_controller.dart';
import 'my_note_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MyNotesScreen extends StatelessWidget {
  const MyNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // final NoteController noteController = Get.put(NoteController());
        // noteController.getNotes();
        await Get.offAllNamed('/'); //
        // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        return Future.value(true);
      },
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 14.0),
              child: Text(
                'My Notes',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            UserNotes(),
          ],
        ),
      ),
    );
  }
}

class UserNotes extends StatelessWidget {
  UserNotes({Key? key}) : super(key: key);
  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => noteController.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : Expanded(
            child: ListView.builder(
              itemCount: noteController.userNotes.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: MyNoteCard(
                        note: noteController.userNotes[index],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),);
  }
}
