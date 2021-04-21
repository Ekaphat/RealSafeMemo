import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/note.dart';
import 'package:flutter_tutorial/utils/database_helper.dart';
import 'package:flutter_tutorial/screens/note_detail.dart';
import 'package:sqflite/sqflite.dart';


Color c = const Color.fromRGBO(9, 50, 94, 80);

class NoteList extends StatefulWidget{
  static String tag = 'note-list';
  @override
  State<StatefulWidget> createState(){
    return NoteListState();
  }
}

class NoteListState extends State<NoteList>{

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if(noteList == null){
      noteList = List<Note>();
      updateListView();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo[900],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Notes'),
        ),
        body: getNoteListView(),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            child:  MaterialButton(
              onPressed: () async{
                await FirebaseAuth.instance.signOut();
              },
              child: Text("Sign out"),
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: (){
            debugPrint('FAB clicked');
            navigateToDetail(Note('', '',2),'Add Note');
          },
          backgroundColor: Colors.indigo[900],
          tooltip: 'Add Note',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context , int position){
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: getPriorityColor(this.noteList[position].priority),
                child: getPriorityIcon(this.noteList[position].priority),
              ),
              title: Text(this.noteList[position].date), //Button for checking the finger touch the button
              trailing: GestureDetector(
                child: Icon(Icons.delete,color: Colors.grey,),
                onTap: (){
                  _delete(context,noteList[position]);
                },
              ),
              onTap: (){
                debugPrint('ListTile Tapped');
                navigateToDetail(this.noteList[position],'Edit Note');
              },
            ),
          );
        }
    );
  }

  Icon getPriorityIcon(int priority){
    switch (priority){
      case 1 :
        return Icon(Icons.play_arrow);
        break;
      case 2 :
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  Color getPriorityColor(int priority) {
    switch (priority){
      case 1 :
        return Colors.red;
        break;
      case 2 :
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);

    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Note note, String title) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
      return NoteDetail(note,title);
    }));

    if(result == true){
      updateListView();
    }
  }

  void updateListView(){
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
     dbFuture.then((database){
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
     noteListFuture.then((noteList){
       setState(() {
         this.noteList = noteList;
         this.count = noteList.length;
       });
     });
    });
  }
}

