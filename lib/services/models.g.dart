// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notes _$NotesFromJson(Map<String, dynamic> json) => Notes(
      title: json['title'] as String? ?? "",
      note: json['note'] as String? ?? "",
      color: json['color'] as String? ?? "4278351805",
      datecreated: json['datecreated'] as String? ?? "",
      noteid: json['noteid'] as String? ?? "",
      lastupdated: json['lastupdated'] as String? ?? "",
      isPublic: json['isPublic'] as bool? ?? true,
      uid: json['uid'] as String? ?? "",
      pfp: json['pfp'] as String? ?? "",
    );

Map<String, dynamic> _$NotesToJson(Notes instance) => <String, dynamic>{
      'title': instance.title,
      'note': instance.note,
      'datecreated': instance.datecreated,
      'lastupdated': instance.lastupdated,
      'color': instance.color,
      'noteid': instance.noteid,
      'isPublic': instance.isPublic,
      'uid': instance.uid,
      'pfp': instance.pfp,
    };

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      task: json['task'] as String? ?? "",
      isChecked: json['isChecked'] as bool? ?? false,
      uid: json['uid'] as String? ?? "",
      taskid: json['taskid'] as String? ?? "",
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'task': instance.task,
      'isChecked': instance.isChecked,
      'uid': instance.uid,
      'taskid': instance.taskid,
    };
