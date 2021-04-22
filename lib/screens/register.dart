import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/login_page.dart';

class register extends StatefulWidget {
  static String tag = 'register-page';

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {

  String _email;
  String _password;
  String _aucode;

  createAlertDialog(BuildContext context){
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text('Permission'),
        content: Text('Your permission is denied'),
        actions: <Widget>[
          MaterialButton(
              elevation: 5.0,
              child: Text('OK'),
              onPressed: ()=>Navigator.pop(context),
          )
        ],
      );
    });
  }

  Future<void> _createUser() async {
    if (_aucode == 'SafeMemo') {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        print("User: $userCredential");
      } on FirebaseAuthException catch (e) {
        print("Error: $e");
      } catch (e) {
        print("Error: $e");
      }
    }
    else {
      createAlertDialog(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value){
                _email = value;
              },
              decoration: InputDecoration(
                hintText: "Enter Email..."
              ),
            ),
            TextField(
              onChanged: (value){
                _password = value;
              },
              decoration: InputDecoration(
                  hintText: "Enter password..."
              ),
            ),
            TextField(
              onChanged: (value){
                _aucode = value;
              },
              decoration: InputDecoration(
                  hintText: "Enter Authentication code"
              ),
            ),
            MaterialButton(
                child: Text("Create new account"),
                onPressed: _createUser
            ),
          ],
        ),
      ),
    );
  }
}
