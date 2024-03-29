
import 'dart:core';

import 'package:flutter_course_work/UI/button.dart';
import 'package:flutter_course_work/controllers/task_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course_work/style/app_style.dart';
import 'package:flutter_course_work/widgets/input_field.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';


class AddTaskPage extends StatefulWidget {

  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  final TaskController _taskController = Get.put(TaskController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  String _endTime= "9:30 PM";
  String _startTime=DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList=[
    5,
    10,
    15,
    20,
  ];

  String _selectedRepeat = "Никогда";
  List<String> repeatList=[
    "Никогда",
    "Каждый день",
    "Каждую неделю",
    "Каждый месяц",
  ];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addAppBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Добавить задачу", style: headingStyle),
              MyInputField(title: "Тема", hint: "Текст темы",controller: _titleController,),
              MyInputField(title: "Заметка", hint: "Текст заметки",controller: _noteController,),
              MyInputField(
                title: "Дата", hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined),
                  onPressed: () {
                    _getDateFromUser();
                  },
                )
                ,),
              Row(
                children: [
                  Expanded(
                      child: MyInputField(
                        title: "Начало",
                        hint:_startTime,
                        widget: IconButton(
                          icon: Icon(Icons.access_time_rounded),
                          onPressed: () {_getTimeFromUser(isStartTime: true);  },
                        ),
                      )
                  ),
                  Expanded(
                      child: MyInputField(
                        title: "Конец",
                        hint:_endTime,
                        widget: IconButton(
                          icon: Icon(Icons.access_time_rounded),
                          onPressed: () {_getTimeFromUser(isStartTime: false);  },
                        ),
                      )
                  )
                ],
              ),
              MyInputField(title: "Напоминание", hint: "за $_selectedRemind минут до",
              widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 32,
                elevation: 4,
                style: subTitleStyle,
                underline: Container(height: 0,),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRemind = int.parse(newValue!);
                  });
                },
                items: remindList.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
                }
                ).toList(),
              )
              ),
              MyInputField(title: "Повтор", hint: "$_selectedRepeat",
                  widget: DropdownButton(
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                    underline: Container(height: 0,),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRepeat = newValue!;
                      });
                    },
                    items: repeatList.map<DropdownMenuItem<String>>((String? value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value!, style: TextStyle(color: Colors.grey),),
                      );
                    }
                    ).toList(),
                  )
              ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  MyButton(label: "Создать задачу", onTap: ()=>_validateDate())
                ],
              )



            ],
          ),
        ),
      ),
    );
  }


  _validateDate(){
    if(_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty){
      _addTaskToDb();
      Get.back();
    }else if(_titleController.text.isEmpty||_noteController.text.isEmpty){
      Get.snackbar("Ошибка", "Все поля должны быть заполнены",
      snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.red,
        icon: Icon(Icons.warning_amber_rounded,
        color: Colors.red,)
      );
    }

  }
  _addTaskToDb() async {
    int value = await _taskController.addTask(
        task: Task(
          note: _noteController.text,
          title:_titleController.text,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          endTime: _endTime,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
          color: _selectedColor,
          isCompleted: 0,
        )
    );
    print("id: $value");
  }
  _colorPallete(){return Column(
    crossAxisAlignment: CrossAxisAlignment.start ,
    children: [
      Text("Цвет", style: titleStyle,),
      SizedBox(height: 8,),

      Wrap(
        children: List<Widget>.generate(3, (int index){
            return GestureDetector(
              onTap: (){
                setState(() {
                  _selectedColor=index;

                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index==0?Colors.indigoAccent:index==1?Colors.amber:Colors.red,
                  child: _selectedColor == index?Icon(
                    Icons.done,
                    color:Colors.white,
                    size: 16,
                  ):Container(),
                ),
              ),
            );
          },
        ),
      )
    ],
  );}


  _addAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.blueAccent,
      title: Text(" "),
      centerTitle: true,
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2024),
    );
    if(_pickerDate!=null){
      setState(() {
        _selectedDate = _pickerDate;

      });
    }
    else {
      print("выбери дату");
    }
  }
  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if(pickedTime==null){
      print("время неверное");
    }
    else if(isStartTime==true){setState(() {
  _startTime = _formatedTime;
});
}
    else if(isStartTime==false){setState(() {
  _endTime = _formatedTime;
});
}
  }
  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0])
        )
    );
  }
}



