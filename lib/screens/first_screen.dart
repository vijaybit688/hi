import 'package:click2chat/constants/colors.dart';
import 'package:click2chat/screens/settings.dart';
import 'package:click2chat/screens/status_saver.dart';
import 'package:click2chat/screens/wallpaper.dart';
import 'package:click2chat/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int pageIndex = 0;
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: DEEP_PURPLE,
          selectedItemColor: Colors.white,
          iconSize: 24,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
            BottomNavigationBarItem(
                icon: Icon(Icons.wallpaper), label: "Wallpaper"),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_circle_down_sharp), label: "Status"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
          onTap: navigationBarFunction,
          currentIndex: pageIndex,
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: pageViewFunction,
          children: [
            Home(),
            Wallpapers(),
         //   StatusSaver(),
            Settings(),
          ],
        ));
  }

  void navigationBarFunction(int value) {
    pageController.animateToPage(value,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void pageViewFunction(int index) {
    setState(() {
      pageIndex = index;
    });
  }
}
