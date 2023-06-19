import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course_work/db/db_helper.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter_course_work/screens/home_screen.dart';
import 'package:flutter_course_work/screens/start_screen.dart';
import 'package:flutter_course_work/style/app_style.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBheler.initDb();
  //await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
     home: StartScreen(),
    );
  }
}

