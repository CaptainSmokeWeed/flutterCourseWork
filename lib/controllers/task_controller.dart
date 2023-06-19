import 'package:flutter_course_work/db/db_helper.dart';
import 'package:flutter_course_work/models/task.dart';
import 'package:get/get.dart';

class TaskController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }

  Future<int> addTask({Task? task}) async{
    return await DBheler.insert(task);
  }
}