// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_app/services/auth.dart';
import 'package:notes_app/services/firestore.dart';
import 'package:notes_app/services/models.dart';

import 'add_note_screen.dart';

class MyNoteCard extends StatelessWidget {
  MyNoteCard({
    required this.note,
  });
  final Notes note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, left: 12, bottom: 12),
      child: GestureDetector(

        onLongPress: (){
          FirestoreService().deleteNote(note.noteid);
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false); //home screen
          Navigator.pushNamed(context, '/my');
        },
        onTap: (){
          Navigator.of(context)
              .push(MaterialPageRoute(builder:(context)=>AddNoteScreen(myNote: note,)));

        },
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
              color: Color(int.parse(note.color)),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        note.title,
                        style: TextStyle(fontSize: 27, color: Colors.white, fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    note.pfp == "" ?
                    CircleAvatar(
                      foregroundImage: AssetImage("assets/icons/yolo.jpg"),
                    ):
                    CircleAvatar(
                      foregroundImage: NetworkImage(note.pfp),
                    )
                  ],
                ),
                Flexible(
                  child: Text(
                    note.note,
                    style: TextStyle(fontSize: 21, color: Colors.white.withOpacity(0.7)),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    note.lastupdated,
                    style: TextStyle(
                        color: Colors.white.withOpacity(.9),
                        fontSize: 21,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
