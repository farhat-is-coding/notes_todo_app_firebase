import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/services/models.dart';
import 'auth.dart';

class FirestoreService {

  // Adding a new note in the firestore
  String addNote(String title, String note, String theme, bool isPublic) {
    final now = DateTime.now();
    final docRef = FirebaseFirestore.instance.collection("notes").doc();
    final data = <String, dynamic>{
      "datecreated": DateFormat.yMMMMd('en_US').add_jm().format(now),
      "noteid": docRef.id,
      "uid": AuthService().user?.uid,
      "title": title,
      "note": note,
      "lastupdated": DateFormat.yMd().format(now),
      "color": theme,
      "isPublic": isPublic,
      "timestamp": DateTime.now(),
      "pfp": AuthService().user?.photoURL ??
          "https://pbs.twimg.com/media/FkXvaBSX0AoAXcB.jpg"
    };

    docRef.set(data, SetOptions(merge: true)).then(
        (value) => log("DocumentSnapshot successfully updated!"),
        onError: (e) => log("Error updating document $e"));
    return docRef.id;
  }

  // Updating a note in the firestore
  Future<void> updateNote(
      String title, String note, String theme, String noteid, bool isPublic) {
    final now = DateTime.now();
    final ref = FirebaseFirestore.instance.collection("notes").doc(noteid);
    var data = {
      "uid": AuthService().user?.uid,
      "title": title,
      "note": note,
      "lastupdated": DateFormat.yMd().format(now),
      "color": theme,
      "isPublic": isPublic,
      "timestamp": DateTime.now(),
      "pfp": AuthService().user?.photoURL ??
          "https://pbs.twimg.com/media/FkXvaBSX0AoAXcB.jpg"
    };
    return ref.set(data, SetOptions(merge: true));
  }

  // Updating a note's privacy in the firestore, if its private no one except the user who created it can see it
  Future<void> updateNotePrivacy(String noteid, bool isPublic) {
    if (noteid == "") {
      return Future.value(null);
    }

    final now = DateTime.now();
    final ref = FirebaseFirestore.instance.collection("notes").doc(noteid);
    var data = {
      "uid": AuthService().user?.uid,
      "lastupdated": DateFormat.yMd().format(now),
      "isPublic": isPublic
    };
    return ref.set(data, SetOptions(merge: true));
  }

  // Updating a note's color in the firestore 
  Future<void> updateNoteColor(String noteid, String theme) {
    if (noteid == "") {
      return Future.value(null);
    }

    final now = DateTime.now();
    final ref = FirebaseFirestore.instance.collection("notes").doc(noteid);
    var data = {
      "uid": AuthService().user?.uid,
      "lastupdated": DateFormat.yMd().format(now),
      "color": theme,
    };
    return ref.set(data, SetOptions(merge: true));
  }

  // Deleting a note from the firestore 
  Future<void> deleteNote(String noteid) {
    final ref = FirebaseFirestore.instance.collection("notes").doc(noteid);
    return ref.delete();
  }

  // Adding a new todo in the firestore
  Future<void> addTodo(String task) {
    final docRef = FirebaseFirestore.instance.collection("todo").doc();
    final data = <String, dynamic>{
      "taskid": docRef.id,
      "uid": AuthService().user?.uid,
      "task": task,
      "isChecked": false,
      "timestamp": DateTime.now(),
    };
    return docRef.set(data, SetOptions(merge: true));
  }

  
  Future<void> deleteTodo(String taskid) {
    final ref = FirebaseFirestore.instance.collection("todo").doc(taskid);
    return ref.delete();
  }


  Future<void> updateTodo(String taskid, bool status) async {
    final ref = FirebaseFirestore.instance.collection("todo").doc(taskid);
    final data = <String, dynamic>{
      "taskid": taskid,
      "uid": AuthService().user?.uid,
      "isChecked": status,
      "timestamp": DateTime.now(),
    };
    return await ref.set(data, SetOptions(merge: true));
  }

  Future<List<Notes>> getAllNotes() async {
    try {
      var ref = FirebaseFirestore.instance
          .collection('notes')
          .where("isPublic", isEqualTo: true)
          .orderBy("timestamp", descending: true);
      var snapshot =
          await ref.get(); // get gets a document only once (not realtime)
      var data = snapshot.docs.map((s) => s.data()); // foreach loop is used
      var notes = data.map((d) => Notes.fromJson(d));
      return notes.toList();
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<List<Todo>> getAllTodos() async {
    final ref = FirebaseFirestore.instance
        .collection("todo")
        .orderBy("timestamp", descending: true);
    var snapshot =
        await ref.get(); // get gets a document only once (not realtime)
    var data = snapshot.docs.map((s) => s.data()); // foreach loop is used
    var todos = data.map((d) => Todo.fromJson(d));
    return todos.toList();
  }

  Future<List<Notes>> getUserNotes() async {
    var ref = FirebaseFirestore.instance
        .collection('notes')
        .where("uid", isEqualTo: AuthService().user?.uid)
        .orderBy("timestamp", descending: true);
    var snapshot =
        await ref.get(); // get gets a document only once (not realtime)
    var data = snapshot.docs.map((s) => s.data()); // foreach loop is used
    var notes = data.map((d) => Notes.fromJson(d));
    return notes.toList();
  }

  
  Future<List<Todo>> getUserTodos() async {
    final ref = FirebaseFirestore.instance
        .collection("todo")
        .where("uid", isEqualTo: AuthService().user?.uid)
        .orderBy("timestamp", descending: true);
    var snapshot =
        await ref.get(); // get gets a document only once (not realtime)
    var data = snapshot.docs.map((s) => s.data()); // foreach loop is used
    var todos = data.map((d) => Todo.fromJson(d));
    return todos.toList();
  }

  // If i was using a stream

  // Stream<List<Notes>> getUserTodos() {
  //   var ref = FirebaseFirestore.instance
  //       .collection('todo')
  //       .where("uid", isEqualTo: AuthService().user?.uid)
  //       .orderBy("timestamp", descending: true);

  //   return ref.snapshots().map((snapshot) {
  //     var data = snapshot.docs.map((s) => s.data()).toList();
  //     var notes = data.map((d) => Notes.fromJson(d)).toList();
  //     return notes;
  //   });
  // }
}
