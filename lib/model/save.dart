import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
class Save{
  String _email = "";
  String _blogId = "";
  Timestamp _timestamp = Timestamp(0, 0);

  Save(this._email, this._blogId, this._timestamp);

  Timestamp get timestamp => _timestamp;

  set timestamp(Timestamp value) {
    _timestamp = value;
  }

  String get blogId => _blogId;

  set blogId(String value) {
    _blogId = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }
}