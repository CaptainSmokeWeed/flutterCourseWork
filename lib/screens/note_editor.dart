import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../style/app_style.dart';

class NoteEditorScreen extends StatefulWidget{
  const  NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoteEditorScreenState();
  }

class _NoteEditorScreenState extends State<NoteEditorScreen>{
  int color_id = Random().nextInt(AppStyle.cardsColor.length);

  String date = DateTime.now().toString();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Добавьте новую записку",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Заголовок записки',
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 8),
            Text(date, style: AppStyle.dateTitle,),
            SizedBox(height: 28),

            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Текст записки',
              ),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ) ,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: ()async{
          FirebaseFirestore.instance.collection("notes").add({
            "note_title": _titleController.text,
            "creation_date": date,
            "note_text":_mainController.text,
            "color_id": color_id
          }).then((value){
            print(value.id);
            Navigator.pop(context);
          }).catchError(
                  (error)=>print("Не удалось добавить записку - $error"));
        },
        child: Icon(Icons.save),
      ),
    );
  }

  }