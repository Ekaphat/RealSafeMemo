import 'package:flutter/material.dart';
import 'package:flutter_tutorial/screens/note_list.dart';
import 'login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  final routes = <String,WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    NoteList.tag: (context) => NoteList()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteKeeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color.fromRGBO(9, 50, 94, 1),
        ),
        fontFamily: 'Consolas',
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}
