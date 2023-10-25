import 'package:cloud_firestore/cloud_firestore.dart';

class Like{
  String _blogId;
  String _email;
  Timestamp _time;

  Like(this._blogId, this._email, this._time);

  Timestamp get time => _time;

  set time(Timestamp value) {
    _time = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get blogId => _blogId;

  set blogId(String value) {
    _blogId = value;
  }
}