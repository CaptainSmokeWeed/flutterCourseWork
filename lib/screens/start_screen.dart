
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course_work/UI/add_task_form.dart';
import 'package:flutter_course_work/UI/button.dart';
import 'package:flutter_course_work/controllers/task_controller.dart';
import 'package:flutter_course_work/screens/home_screen.dart';
import 'package:flutter_course_work/style/app_style.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';
import '../widgets/task_tile.dart';

class StartScreen extends StatefulWidget{
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    _taskController.getTasks();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _addAppBar(),
        body: Column(
          children: [
            _addTaskBar(),
            _addDateBar(),
            SizedBox(height: 10,),
            _showTasks(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          label: Text("Записки",),
          icon: Icon(Icons.note),

        )
    );
  }
    _addTaskBar(){return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMd().format(DateTime.now()), style: subHeadingStyle,),
                Text("Сегодня",
                  style: headingStyle,)
              ],
            ),
          ),
          MyButton(label: "+ Добавить задачу", onTap: ()async{
            await Get.to(AddTaskPage());
            _taskController.getTasks();
          }
          )
        ],
      ),
    );}
    _addAppBar(){return AppBar(
      elevation: 0,
      backgroundColor: Colors.blueAccent,
      title: Text("Добро пожаловать"),
      centerTitle: true,
    );}
    _addDateBar(){return Container(
      margin: const EdgeInsets.only(top: 20,left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.blue,
        selectedTextColor: Colors.white,

        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),

        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),

        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (date){
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );}
  _showTasks(){
    return Expanded(
        child: Obx((){
          return ListView.builder(
              itemCount: _taskController.taskList.length,

              itemBuilder: (_, index){
                print(_taskController.taskList.length);
                Task task = _taskController.taskList[index];
                if(task.repeat=='Каждый день') {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    _showBottomSheet(context, task);
                                  },
                                  child: TaskTile(task)
                              )
                            ],
                          ),
                        ),
                      )
                  );
                }
                if(task.repeat=='Каждую неделю') {
                  if(task.date==DateFormat.d().format(_selectedDate))
                  {return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                  child: FadeInAnimation(
                  child: Row(
                  children: [
                  GestureDetector(
                  onTap: () {
                  _showBottomSheet(context, task);
                  },
                  child: TaskTile(task)
                  )
                  ],
                  ),
                  ),
                  )
                  );};
                }
                if(task.repeat=='Каждый месяц') {
                  if(task.date==DateFormat.M().format(_selectedDate))
                  {return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    _showBottomSheet(context, task);
                                  },
                                  child: TaskTile(task)
                              )
                            ],
                          ),
                        ),
                      )
                  );};
                }
                if(task.date==DateFormat.yMd().format(_selectedDate)){
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    _showBottomSheet(context, task);
                                  },
                                  child: TaskTile(task)
                              )
                            ],
                          ),
                        ),
                      )
                  );
                }
                else{
                  return Container();
                }


              });
        })
    );
  }
  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    required BuildContext context,
    bool isClose = false,
  }){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,

        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose?Colors.grey[400]!:clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose==true?Colors.white:clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose?titleStyle:titleStyle.copyWith(color:Colors.white),
          ),
        ),
      ),

    );
  }
  _showBottomSheet(BuildContext context, task){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted==1?
            MediaQuery.of(context).size.height*0.24:
            MediaQuery.of(context).size.height*0.32,
          color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300]
              ),
            ),
            Spacer(),
            task.isCompleted==1?
                Container():
                _bottomSheetButton(
                  label: "Выполнено",
                  onTap: (){
                    _taskController.markTaskCompleted(task.id);
                    Get.back();
                    },
                  clr: Colors.blue,
                  context:context
                ),

                _bottomSheetButton(
                  label: "Удалить",
                  onTap: (){
                    _taskController.delete(task);
                    Get.back();
                    },
                  clr: Colors.red[300]!,
                  context:context
                ),
            SizedBox(height: 20,),
                _bottomSheetButton(
                  label: "Закрыть",
                  onTap: (){Get.back();},
                  clr: Colors.white,
                  isClose: true,
                  context:context
                ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
