import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/screens/note_list.dart';
import 'package:flutter_tutorial/screens/register.dart';
import 'login_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LandingPage extends StatelessWidget {
  final routes = <String,WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    NoteList.tag: (context) => NoteList(),
    register.tag: (context) => register(),
  };

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder:(context, snapshot) {
        if(snapshot.hasError){
          return Scaffold(
            body: Center(
                child: Text("Error: ${snapshot.error}")
            ),
          );
        }

        if(snapshot.connectionState== ConnectionState.done){
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.active){
                  User user = snapshot.data;

                  if(user == null) {
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
                  } else {
                    return NoteList();
                  }
                }

                return Scaffold(
                  body: Center(
                    child: Text("Checking Authentication ......."),
                  ),
                );
              }
          );
        }
        return Scaffold(
          body: Center(
            child: Text("Connecting to app ......."),
          ),
        );
      },
    );
  }
}


