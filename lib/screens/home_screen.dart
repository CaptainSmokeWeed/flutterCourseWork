import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_work/screens/note_editor.dart';
import 'package:flutter_course_work/screens/note_reader.dart';
import 'package:flutter_course_work/style/app_style.dart';
import 'package:flutter_course_work/widgets/note_card.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget{
   const HomeScreen({Key? key}) : super(key: key);

   @override
    State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Записки"),
        centerTitle: true,
        backgroundColor: AppStyle.bgColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ваши записки", style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(
            height: 20,),
          Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("notes").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData){
                return GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  children: snapshot.data!.docs.map((note)=> noteCard((){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteReaderScreen(note),
                    ));
                  }, note)).toList(),


                );
              }
              return Text("Здесь нет записок", style: GoogleFonts.nunito(color: Colors.white),);

            }

          )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteEditorScreen()));
        },
        label: Text("Добавить Записку"),
        icon: Icon(Icons.add),
      ),

    );
  }

}