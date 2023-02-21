// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notes_app/services/firestore.dart';
import '../../../services/models.dart';
import 'my_note_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MyNotesScreen extends StatelessWidget {
  MyNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        return Future.value(true);
      },
      child: UserNotes(),
    );

  }

}

class UserNotes extends StatelessWidget {
  const UserNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Notes>>(
      future: FirestoreService().getUserNotes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> notesList = [Padding(
            padding: const EdgeInsets.only(top: 10, left: 12),
            child: Text("Your Notes",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800)),
          ),];
          var notes = snapshot.data;
          for (var note in notes!) {
            notesList.add(MyNoteCard(
              note: note,
            ));
          }
          return ListView.builder(
            itemCount: notesList.length,
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
