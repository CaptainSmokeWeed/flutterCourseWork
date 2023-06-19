import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course_work/UI/add_task_form.dart';
import 'package:flutter_course_work/UI/button.dart';
import 'package:flutter_course_work/screens/home_screen.dart';
import 'package:flutter_course_work/style/app_style.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class StartScreen extends StatefulWidget{
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}


class _StartScreenState extends State<StartScreen> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _addAppBar(),
        body: Column(
          children: [
            _addTaskBar(),
            _addDateBar(),],
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
          MyButton(label: "+ Добавить задачу", onTap: ()=> Get.to(AddTaskPage()))
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
          _selectedDate = date;
        },
      ),
    );}
}
