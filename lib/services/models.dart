import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class Notes{
  Notes({this.title= "", this.note = "", this.color= "4278351805", this.datecreated = "", this.noteid="", this.lastupdated="", this.isPublic=true, this.uid="", this.pfp=""});
  String title;
  String note;
  String datecreated;
  String lastupdated;
  String color;
  String noteid;
  bool isPublic;
  String uid;
  String pfp;

  factory Notes.fromJson(Map<String, dynamic> json) => _$NotesFromJson(json);
  Map<String, dynamic> toJson() => _$NotesToJson(this);
}

@JsonSerializable()
class Todo{
  Todo({this.task= "", this.isChecked = false, this.uid="", this.taskid=""});
  String task;
  bool isChecked;
  String uid;
  String taskid;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}