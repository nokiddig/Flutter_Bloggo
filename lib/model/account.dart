import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/constains/my_const.dart';

class Account {
  String _name = "";
  String _email = "";
  String? _avatarPath;
  bool _status = true;
  int _gender = 0;

  Account.clone(this._email);


  Account(this._name, this._email, this._avatarPath, this._status, this._gender);

  factory Account.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Account(
        data[ModelConst.FIELD_NAME],
        doc.id,
        data[ModelConst.FIELD_AVATAR],
        data[ModelConst.FIELD_STATUS],
        data[ModelConst.FIELD_GENDER]);
  }

  int get gender => _gender;

  set gender(int value) {
    _gender = value;
  }

  bool get status => _status;

  set status(bool value) {
    _status = value;
  }

  String get avatarPath => _avatarPath ?? "";

  set avatarPath(String value) {
    _avatarPath = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}