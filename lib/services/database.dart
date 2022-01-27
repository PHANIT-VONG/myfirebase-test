import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/todo_model.dart';
import 'package:firebase_test/models/user_model.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final DocumentSnapshot _doc;
  Future<bool> createNewUser(UserModel userModel) async {
    try {
      await _firestore.collection('tbUser').doc(userModel.id).set({
        'name': userModel.name,
        'email': userModel.email,
      });
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      _doc = await _firestore.collection('tbUser').doc(uid).get();
      return UserModel.fromDocumentSnapshot(_doc);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTodo(String content, String uid) async {
    try {
      await _firestore.collection('tbUser').doc(uid).collection('tbTodo').add({
        'dateCreated': Timestamp.now(),
        'content': content,
        'done': false,
      });
    } catch (e) {
      print('Add Todo Error : $e');
      rethrow;
    }
  }

  Stream<List<TodoModel>> todoStream(String uid) {
    return _firestore
        .collection('tbUser')
        .doc(uid)
        .collection('tbTodo')
        .orderBy('dateCreated', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> list = [];
      for (var element in query.docs) {
        list.add(TodoModel.fromDocumentSnapshot(element));
      }
      return list;
    });
  }

  Future<void> updateTodo(bool newValue, String uid, String todoId) async {
    try {
      await _firestore
          .collection('tbUser')
          .doc(uid)
          .collection('tbTodo')
          .doc(todoId)
          .update({
        'done': newValue,
      });
    } catch (e) {
      print('Update Todo Error : $e');
      rethrow;
    }
  }
}
