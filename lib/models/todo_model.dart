import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? todoId;
  String? content;
  Timestamp? dateCreated;
  bool? done;

  TodoModel({this.todoId, this.content, this.dateCreated, this.done});

  TodoModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    todoId = doc.id;
    content = doc['content'];
    dateCreated = doc['dateCreated'];
    done = doc['done'];
  }
}
