// Class นี้เป็นเรื่องของ Model

//สร้างตัวแปรให้สอดคล้องกับ table โดยตามาตรฐานแล้วจะใส่ _ นำหน้าตัวแปรเพื่อให้รู้ว่าเป็นFill
class Note{
  int _id;
  String _title;
  String _description;
  int _priority;
  String _date;

  //Constructor
  Note(this._title,this._date,this._priority,[this._description]);
  //put [] in this._description tp make it can change
  //Note with ID use when we need to input new note we have a new id
  Note.withID(this._id,this._title,this._date,this._priority,[this._description]);

  //Get
  int get id => _id;
  String get title => _title;
  String get date => _date;
  int get priority => _priority;
  String get description => _description;

  //Set
  set title(String newTitle){
    if(newTitle.length<=255){
      this._title = newTitle;
    }
  }
  set description(String newDescription){
    if(newDescription.length<=255){
      this._description = newDescription;
    }
  }
  set priority(int newPriority){
    if(newPriority>=1 && newPriority<=2){
      this._priority = newPriority;
    }
  }
  set date(String newDate){
    this._date = newDate;
  }

  //change Note OBJ to be Map OBJ
  Map<String, dynamic> toMap(){
    var map = Map<String , dynamic>();
    //case of edit data not add new data
    if(id != null){
      map['id'] = _id;
    }

    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

    //กระจาย obj ออกมาเป็น map obj
  Note.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._priority = map['priority'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
  }
}


