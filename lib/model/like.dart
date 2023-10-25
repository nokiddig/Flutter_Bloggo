import 'package:cloud_firestore/cloud_firestore.dart';

class Like{
  String _blog_id;
  String _email;
  Timestamp time;

  Like(this._blog_id, this._email, this.time);


}