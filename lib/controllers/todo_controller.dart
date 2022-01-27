import 'package:firebase_test/controllers/auth_controller.dart';
import 'package:firebase_test/models/todo_model.dart';
import 'package:firebase_test/services/database.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  final Rx<List<TodoModel>> _todoList = Rx<List<TodoModel>>([]);
  List<TodoModel> get todos => _todoList.value;

  @override
  void onInit() {
    String uid = Get.find<AuthController>().user!.uid;
    _todoList.bindStream(Database().todoStream(uid));
    super.onInit();
  }
}
