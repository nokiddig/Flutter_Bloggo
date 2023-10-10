import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/constains/my_const.dart';

class Account {
  String _id;
  String _name = "";
  String _password = "";
  String? _avatarPath;

  Account(this._id, this._name, this._password, this._avatarPath);

  factory Account.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Account(
        doc.id,
        data[ModelConst.FIELD_NAME],
        data[ModelConst.FIELD_PASS],
        data[ModelConst.FIELD_AVATAR]);
  }

  String get avatarPath => _avatarPath??"";

  set avatarPath(String value) {
    _avatarPath = value;
  }

  get password => _password;

  set password(value) {
    _password = value;
  }

  String get username => _name;

  set username(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}