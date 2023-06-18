import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course_work/screens/home_screen.dart';
import 'package:flutter_course_work/style/app_style.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatefulWidget{
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}


class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Добро пожаловать", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22,)
        ),
       ),
      body:
      Column(

      ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));},
          label: Text("Записки",),
          icon: Icon(Icons.note),
        )
    );
  }
}