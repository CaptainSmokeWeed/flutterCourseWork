import 'package:flutter_course_work/db/db_helper.dart';
import 'package:flutter_course_work/models/task.dart';
import 'package:get/get.dart';

class TaskController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async{
    return await DBheler.insert(task);
  }

  void getTasks() async{
    List<Map<String, dynamic>> tasks= await DBheler.query();
    taskList.assignAll(tasks.map((data)=> new Task.fromJson(data)).toList());
  }

  void delete(Task task){
    var val = DBheler.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id)async{
    await DBheler.update(id);
    getTasks();
  }
}