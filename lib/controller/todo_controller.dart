import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/services/firestore.dart';
import 'package:notes_app/services/models.dart';

class TodoController extends GetxController {
  /// You do not need that. I recommend using it just for ease of syntax.
  /// with static method: Controller.to.increment();
  /// with no static method: Get.find<Controller>().increment();
  /// There is no difference in performance, nor any side effect of using either
  /// syntax. Only one does not need the type,
  /// and the other the IDE will autocomplete it.
  ///
  static TodoController get to => Get.find();

  var isLoading = false.obs;
  var allTodos = <Todo>[].obs;
  var userTodos = <Todo>[].obs;

  // var noteController = TextEditingController().obs;
  var titleController = TextEditingController().obs;
  // var focusNote = FocusNode().obs;
  var focusTitle = FocusNode().obs;

  @override
  void onInit() {
    super.onInit();
    // call API
    getTodos();
    getUserTodos();
  }

  Future<void> getTodos() async {
    isLoading(true);
    allTodos(await FirestoreService().getAllTodos());
    isLoading(false);
  }

  Future<void> getUserTodos() async {
    isLoading(true);
    userTodos(await FirestoreService().getUserTodos());
    isLoading(false);
  }

  Future<void> addTodo() async {
    isLoading(true);
    await FirestoreService().addTodo(titleController.value.text);
    isLoading(false);

    // reset the text field
    titleController.value.clear();
    focusTitle.value.requestFocus();
  }
}
