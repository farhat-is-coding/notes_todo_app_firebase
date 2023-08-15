import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/note_controller.dart';
import '../../../services/models.dart';

class NoteCard extends StatelessWidget {
  NoteCard({
    super.key,
    required this.note,
    this.iconSrc = "assets/icons/2.jpg",
  });

  final String iconSrc;
  final Notes note;
  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          // use Get to navigate to the screen
          noteController.setNote(note);
          Get.toNamed('/addnote');
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => AddNoteScreen(
          //           myNote: note,
          //         )));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          height: 350,
          width: 260,
          decoration: BoxDecoration(
            color: Color(int.parse(note.color)),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 6, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                note.pfp == ""
                    ? CircleAvatar(
                        backgroundImage: AssetImage(iconSrc),
                        radius: 40,
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(note.pfp),
                        radius: 40,
                      ),
                Text(
                  note.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 30),
                  overflow: TextOverflow.ellipsis,
                ),
                Flexible(
                  child: Text(
                    note.note,
                    style: const TextStyle(color: Colors.white38, fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
