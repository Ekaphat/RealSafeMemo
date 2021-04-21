import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/screens/note_list.dart';
import 'package:flutter_tutorial/screens/register.dart';

Color c = const Color.fromRGBO(9, 50, 94, 80);

class LoginPage extends StatefulWidget{
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  String _email;
  String _password;

  Future<void> _createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      print("User: $userCredential");
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch (e){
      print("Error: $e");
    }
  }

  Future<void> _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      print("User: $userCredential");
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch (e){
      print("Error: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    final logo = Hero(
        tag: Hero,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 64.0,
          child: Image.asset('images/SafeNoteLogo.png'),
        )
    );

    final email = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      //initialValue: '',
      style: TextStyle(
        color: Colors.white,
        decorationColor: Colors.white,
      ),
      onChanged: (value){
        _email = value;
      },
      decoration: InputDecoration(

          hintText: 'email...',
          hintStyle: TextStyle( color: Colors.white),
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(
                color: Colors.white,
              )

          )
      ),
    );

    final password = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      style: TextStyle(
        color: Colors.white,
      ),
      onChanged: (value){
        _password = value;
      },
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'password...',
          hintStyle: TextStyle( color: Colors.white),
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: new BorderSide(color: Colors.white)
          )
      ),
    );

    final createUserButton = Padding(
      padding: EdgeInsets.all( 10.0),
      child: MaterialButton(
        minWidth: 150 ,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24)
        ),
        onPressed: (){
          Navigator.of(context).pushNamed(register.tag);
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlue,
        child: Text('Create account',style: TextStyle(color: Colors.white),),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.all( 10.0),
      child: MaterialButton(
        minWidth: 150 ,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24)
        ),
        onPressed: _login,
        padding: EdgeInsets.all(12),
        color: Colors.lightBlue,
        child: Text('Log in',style: TextStyle(color: Colors.white),),
      ),
    );


    return Scaffold(
      backgroundColor: c,
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(left: 24.0,right: 24.0),
          shrinkWrap: true, //to go to new line when text is too much
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            Row(
              children: [createUserButton,loginButton],
            )
            //SizedBox(height: 24.0), // not necessary because flat button has their own height
          ],
        ),
      ),
    );
  }
}