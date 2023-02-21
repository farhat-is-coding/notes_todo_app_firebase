import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../services/firestore.dart';
import '../../services/models.dart';
import '../my_screen/my_user_note_screen/my_note_card.dart';
import 'note_card.dart';

class NotesRow extends StatelessWidget {
  NotesRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Notes>>(
      future: FirestoreService().getAllNotes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> notesList = [];
          var notes = snapshot.data;
          int i = 0;
          for (var note in notes!) {
            //log(note.pfp);
            notesList.add(NoteCard(
              note: note,
            ));
          }
          return GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: notesList.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              // mainAxisExtent: 300, /// x axis
                maxCrossAxisExtent: 400,

                /// y axis
                childAspectRatio: 1,
                crossAxisSpacing: 10,

                ///y axis space
                mainAxisSpacing: 10), // x axis space
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: notesList[index],
                  ),
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.blueAccent,
          ),
        );
      },
    );
  }
}