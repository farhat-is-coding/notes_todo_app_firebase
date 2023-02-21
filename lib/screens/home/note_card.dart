import 'dart:developer';

import 'package:flutter/material.dart';
import '../../services/models.dart';
import '../my_screen/my_user_note_screen/add_note_screen.dart';

class NoteCard extends StatelessWidget {
   NoteCard({
    required this.note,
    this.iconSrc = "assets/icons/2.jpg",
  });

  final String iconSrc;
  Notes note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context)
              .push(MaterialPageRoute(builder:(context)=>AddNoteScreen(myNote: note,)));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          height: 350,
          width: 260,
          decoration: BoxDecoration(
            color: Color(int.parse(note.color)),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 6, right: 8),
            child: Column(
              children: [
                note.pfp == ""?
                CircleAvatar(backgroundImage: AssetImage(iconSrc), radius: 40,):
            CircleAvatar(backgroundImage: NetworkImage(note.pfp), radius: 40,),
                Text(
                  note.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30),
                  overflow: TextOverflow.ellipsis,
                ),
                Flexible(
                  child: Text(
                    note.note,
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 17
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}