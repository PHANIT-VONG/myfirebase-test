import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/controllers/auth_controller.dart';
import 'package:firebase_test/controllers/theme_controller.dart';
import 'package:firebase_test/controllers/todo_controller.dart';
import 'package:firebase_test/controllers/user_controller.dart';
import 'package:firebase_test/services/database.dart';
import 'package:firebase_test/views/widgets/themes.dart';
import 'package:firebase_test/views/widgets/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends GetWidget<AuthController> {
  MainPage({Key? key, this.user}) : super(key: key);
  final User? user;
  final _controller = TextEditingController();
  final _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.email.toString()),
        // title: GetX<UserController>(
        //   init: UserController(),
        //   initState: (_) => Get.put<UserController>(UserController()),
        //   builder: (_) {
        //     if (_.user.email != null) {
        //       return Text(
        //         user!.email.toString(),
        //         style: const TextStyle(fontSize: 20.0),
        //       );
        //     } else {
        //       return const Text('Loading...');
        //     }
        //   },
        // ),
        actions: [
          IconButton(
            onPressed: () {
              if (Get.isDarkMode) {
                //Change the theme mode to light mode
                //_themeController.changeThemeMode(ThemeMode.light);
                //Change the theme to light theme
                _themeController.changeTheme(Themes.lightTheme);
                _themeController.saveTheme(false);
              } else {
                //Change the theme mode to light mode
                // _themeController.changeThemeMode(ThemeMode.dark);
                //Change the theme to light theme
                _themeController.changeTheme(Themes.darkTheme);
                _themeController.saveTheme(true);
              }
            },
            icon: const Icon(Icons.color_lens_outlined),
          ),
          IconButton(
            onPressed: () => controller.signOut(),
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(30.0),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(40.0),
            // ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Leave comment',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_controller.text != "") {
                        Database().addTodo(
                          _controller.text,
                          controller.user!.uid,
                        );
                        _controller.clear();
                      }
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
          const Text('Your Todos', style: TextStyle(fontSize: 20.0)),
          GetX<TodoController>(
            init: TodoController(),
            initState: (state) => Get.put<TodoController>(TodoController()),
            builder: (TodoController todoController) {
              if (todoController.todos.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: todoController.todos.length,
                    itemBuilder: (context, index) {
                      var data = todoController.todos[index];
                      return TodoCard(
                        todo: data,
                        uid: controller.user!.uid,
                      );
                    },
                  ),
                );
              } else {
                return const Expanded(
                  child: Center(child: Text('No Comment')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
