import 'package:click2chat/screens/first_screen.dart';
import 'package:click2chat/screens/home.dart';
import 'package:click2chat/screens/settings.dart';
import 'package:click2chat/screens/wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'constants/colors.dart';
import 'constants/routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
    // debug: true // optional: set false to disable printing logs to console
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        RoutesClass.FIRST_SCREEN:(context)=>FirstScreen(),
        RoutesClass.HOME:(context)=>Home(),
        RoutesClass.WALLPAPER:(context)=>Wallpapers(),
        RoutesClass.SETTINGS:(context)=>Settings(),

      },
        theme: ThemeData(

          appBarTheme: AppBarTheme(
            backgroundColor: DEEP_PURPLE,
          ),
          scaffoldBackgroundColor: LIGHT_PURPLE,
        ));

  }
}
