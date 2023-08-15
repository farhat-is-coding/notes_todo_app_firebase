import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/services/auth.dart';
import 'package:notes_app/services/firestore.dart';
import 'package:notes_app/services/models.dart';
import 'package:undo/undo.dart';

class NoteController extends GetxController {
  /// You do not need that. I recommend using it just for ease of syntax.
  /// with static method: Controller.to.increment();
  /// with no static method: Get.find<Controller>().increment();
  /// There is no difference in performance, nor any side effect of using either
  /// syntax. Only one does not need the type,
  /// and the other the IDE will autocomplete it.
  ///
  static NoteController get to => Get.find();

  var isLoading = false.obs;
  var allNotes = <Notes>[].obs;
  var userNotes = <Notes>[].obs;
  var note = Notes().obs;

  // for creating a new note
  var title = "".obs;
  var content = "".obs;
  var pfp = "".obs;
  var noteid = "".obs;
  var isPublic = true.obs;
  var allowFullControl = false.obs;
  var noteuid = "".obs;
  var focused = false.obs;
  var datecreated = "".obs;
  var lastupdated = "".obs;

  var isRedo = false.obs;

  var bgColor = const Color(0xFFEBF6FC);
  var textColor = Colors.lightBlue.shade800.obs;

  var redocontroller = SimpleStack<String>(
    "",
    limit: 50,
    onUpdate: (val) {},
  ).obs;
  var noteController = TextEditingController().obs;
  var titleController = TextEditingController().obs;
  var focusNote = FocusNode().obs;
  var focusTitle = FocusNode().obs;

  @override
  void onInit() {
    super.onInit();
    // call Firestore
    getNotes();
    getUserNotes();
  }

  void getNotes() async {
    isLoading(true);
    allNotes(await FirestoreService().getAllNotes());
    isLoading(false);
  }

  void getUserNotes() async {
    isLoading(true);
    userNotes(await FirestoreService().getUserNotes());
    isLoading(false);
  }

  void setNote(Notes note) {
    title(note.title);
    content(note.note);
    textColor(Color(int.parse(note.color)));
    pfp(note.pfp);
    noteid(note.noteid);
    isPublic(note.isPublic);
    noteuid(note.uid);
    datecreated(note.datecreated);
    lastupdated(note.lastupdated);

    checkStatus();

    noteController.value.value = TextEditingValue(
      text: note.note,
      selection: TextSelection.fromPosition(
        TextPosition(offset: note.note.length),
      ),
    );
    titleController.value.text = note.title;
  }

  void checkStatus() {
    if (noteid.value == "") {
      //
      allowFullControl(true);
      return;
    }
    if (noteuid.value == AuthService().user?.uid) {
      //current user owns this note
      allowFullControl(true);
      return;
    }
    allowFullControl(false);
  }

  Future<void> clickBtn() async {
    //tick button
    log("end function");
    try {
      focusTitle.value.unfocus();
      focusNote.value.unfocus();
      focused(false);

      if (titleController.value.text == "" && noteController.value.text == "") {
        log("null case");
        return;
      }
      if (noteid.value == "") {
        //first generate a document
        log("Create function");
        //  use note controller and title controller
        String nid = FirestoreService().addNote(
            titleController.value.text,
            noteController.value.text,
            textColor.value.value.toString(),
            isPublic.value);

        noteid(nid);
      } else {
        log("Update function");
        FirestoreService().updateNote(
            titleController.value.text,
            noteController.value.text,
            textColor.value.value.toString(),
            noteid.value,
            isPublic.value);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //   if (focusTitle.value.hasFocus){
  //     focused(true);
  //     return;
  //   }
  //   if (focusNote.value.hasFocus){
  //     focused(true);
  //     return;
  //   }
  //   focused(false);
  // }

  void undoBtn() {
    isRedo(true);
    redocontroller.value.undo();
    String val = redocontroller.value.state;
    noteController.value.value = TextEditingValue(
      text: val,
      selection: TextSelection.fromPosition(
        TextPosition(offset: val.length),
      ),
    );
  }

  void redoBtn() {
    isRedo(true);
    redocontroller.value.redo();
    String val = redocontroller.value.state;
    noteController.value.value = TextEditingValue(
      text: val,
      selection: TextSelection.fromPosition(
        TextPosition(offset: val.length),
      ),
    );
  }

  void setPrivacy(bool val) {
    isPublic(val);
    FirestoreService().updateNotePrivacy(noteid.value, val);
  }

  void updateColor(dynamic color) {
    textColor(color);
    log(color.value.toString());
    FirestoreService().updateNoteColor(noteid.value, color.value.toString());
  }
}
