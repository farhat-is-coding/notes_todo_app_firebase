import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:notes_app/controller/note_controller.dart';
import 'note_card.dart';

class NotesRow extends StatelessWidget {
  NotesRow({Key? key}) : super(key: key);

  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => noteController.isLoading.value
          ? const Center(child:  CircularProgressIndicator())
          : GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: noteController.allNotes.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  /// y axis
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  ///y axis space
                  mainAxisSpacing: 10), // x axis space
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 250),
                  child: SlideAnimation(
                    verticalOffset: 200.0,
                    child: FadeInAnimation(
                      child: NoteCard(
                        note: noteController.allNotes[index],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
