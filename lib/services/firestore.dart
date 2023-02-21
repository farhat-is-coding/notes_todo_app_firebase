import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/services/models.dart';
import 'auth.dart';


class FirestoreService{

  String addNote(String title, String note, String theme, bool isPublic) {
    final now = DateTime.now();
    final docRef = FirebaseFirestore.instance.collection("notes").doc();
    final data = <String, dynamic>{
      "datecreated": DateFormat.yMMMMd('en_US').add_jm().format(now),
      "noteid" :  docRef.id,
      "uid": AuthService().user?.uid,
      "title" : title,
      "note": note,
      "lastupdated": DateFormat.yMd().format(now),
      "color": theme,
      "isPublic": isPublic,
      "timestamp": DateTime.now(),
      "pfp": AuthService().user?.photoURL ?? ""
    };

    docRef.set(data, SetOptions(merge: true)).then(
            (value) => log("DocumentSnapshot successfully updated!"),
        onError: (e) => log("Error updating document $e"));
    return docRef.id;
  }

  Future<void> updateNote(String title, String note, String theme, String noteid, bool isPublic) {
    final now = DateTime.now();
    final ref = FirebaseFirestore.instance.collection("notes")
        .doc(noteid);
    var data = {
      "uid": AuthService().user?.uid,
      "title" : title,
      "note": note,
      "lastupdated": DateFormat.yMd().format(now),
      "color": theme,
      "isPublic": isPublic,
      "timestamp": DateTime.now(),
      "pfp": AuthService().user?.photoURL
    };
    return ref.set(data, SetOptions(merge: true));
  }
  Future<void> updateNotePrivacy(String noteid, bool isPublic) {
    if (noteid == ""){return Future.value(null);}

    final now = DateTime.now();
    final ref = FirebaseFirestore.instance.collection("notes")
        .doc(noteid);
    var data = {
      "uid": AuthService().user?.uid,
      "lastupdated": DateFormat.yMd().format(now),
      "isPublic": isPublic
    };
    return ref.set(data, SetOptions(merge: true));
  }
  Future<void> updateNoteColor(String noteid, String theme) {
    if (noteid == ""){return Future.value(null);}

    final now = DateTime.now();
    final ref = FirebaseFirestore.instance.collection("notes")
        .doc(noteid);
    var data = {
      "uid": AuthService().user?.uid,
      "lastupdated": DateFormat.yMd().format(now),
      "color": theme,
    };
    return ref.set(data, SetOptions(merge: true));
  }

  Future<void> deleteNote(String noteid){
    final ref = FirebaseFirestore.instance.collection("notes").doc(noteid);
    return ref.delete();
  }

  Future<void> addTodo(String task){
    final docRef = FirebaseFirestore.instance.collection("todo").doc();
    final data = <String, dynamic>{
      "taskid" :  docRef.id,
      "uid": AuthService().user?.uid,
      "task" : task,
      "isChecked": false,
      "timestamp": DateTime.now(),
    };
    return docRef.set(data, SetOptions(merge: true));
  }
  Future<void> deleteTodo(String taskid){
    final ref = FirebaseFirestore.instance.collection("todo").doc(taskid);
    return ref.delete();
  }
  Future<void> updateTodo(String taskid, bool status){
    final ref = FirebaseFirestore.instance.collection("todo").doc(taskid);
    final data = <String, dynamic>{
      "taskid" :  taskid,
      "uid": AuthService().user?.uid,
      "isChecked": status,
      "timestamp": DateTime.now(),
    };
    return ref.set(data, SetOptions(merge: true));
  }



  Future<List<Notes>> getAllNotes() async {
    try{
      var ref = FirebaseFirestore.instance.collection('notes')
          .where("isPublic", isEqualTo: true)
          .orderBy("timestamp", descending: true); // truckers/smthng
      var snapshot = await ref.get(); // get gets a document only once (not realtime)
      var data = snapshot.docs.map((s) => s.data()); // foreach loop is used
      var notes = data.map((d) => Notes.fromJson(d));
      return notes.toList();
    }
    catch (e){
      log(e.toString());
    }
    //log(topics.toString());
    return [];
  }

  Future<List<Todo>> getAllTodos() async {
    final ref = FirebaseFirestore.instance.collection("todo").orderBy("timestamp", descending: true);
    var snapshot = await ref.get(); // get gets a document only once (not realtime)
    var data = snapshot.docs.map((s) => s.data()); // foreach loop is used
    var todos = data.map((d) => Todo.fromJson(d));
    return todos.toList();
  }

  Future<List<Notes>> getUserNotes() async {
    var ref = FirebaseFirestore.instance.collection('notes')
        .where("uid", isEqualTo: AuthService().user?.uid)
        .orderBy("timestamp", descending: true); // truckers/smthng
    var snapshot = await ref.get(); // get gets a document only once (not realtime)
    var data = snapshot.docs.map((s) => s.data()); // foreach loop is used
    var notes = data.map((d) => Notes.fromJson(d));
    //log(topics.toString());
    return notes.toList();
  }


}