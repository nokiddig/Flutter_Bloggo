import 'package:cloud_firestore/cloud_firestore.dart';

class Noti {
  String _content;
  String _email;
  String _type;
  Timestamp _time;
  String _information;

  Noti(this._content, this._email, this._type, this._time, this._information);

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  Timestamp get time => _time;

  set time(Timestamp value) {
    _time = value;
  }

  String get information => _information;

  set information(String value) {
    _information = value;
  }
}