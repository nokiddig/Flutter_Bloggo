import 'package:blog_app/utils/constain/firebase_model_const.dart';
import 'package:blog_app/viewmodel/viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/account.dart';

class AccountViewModel extends ViewModel<Account>{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final AccountViewModel _instance = AccountViewModel._internal();

  factory AccountViewModel() {
    return _instance;
  }

  AccountViewModel._internal();

  @override
  Future<void> add(Account account)async{
    try {
      await _firestore.collection(MODEL_CONST.COLLECTION_ACCOUNT).doc(account.email)
          .set(convertToMap(account));
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<Account>> getAll() async {
    List<Account> all = [];
    QuerySnapshot querySnapshot = await _firestore.collection(MODEL_CONST.COLLECTION_ACCOUNT).get();
    querySnapshot.docs.forEach((element) {
      all.add(fromFirestore(element));
    });
    return all;
  }

  Future<void> delete(String email) async {
    await _firestore.collection(MODEL_CONST.COLLECTION_ACCOUNT).doc(email).delete();
  }

  Future<void> edit(Account account) async {
    await _firestore.collection(MODEL_CONST.COLLECTION_ACCOUNT).doc(account.email)
        .set(convertToMap(account));
  }

  @override
  Map<String, dynamic> convertToMap(Account account){
    return {
      MODEL_CONST.FIELD_AVATAR: account.avatarPath,
      MODEL_CONST.FIELD_NAME: account.name,
      MODEL_CONST.FIELD_GENDER: account.gender,
      MODEL_CONST.FIELD_STATUS: account.status,
    };
  }

  @override
  Account fromFirestore(DocumentSnapshot<Object?> doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Account(
        data[MODEL_CONST.FIELD_NAME],
        doc.id,
        data[MODEL_CONST.FIELD_AVATAR],
        data[MODEL_CONST.FIELD_STATUS],
        data[MODEL_CONST.FIELD_GENDER]);
  }

  Future<Account?> getByEmail(String email) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try{
      DocumentSnapshot<Map<String, dynamic>> accountSnapshot = await _firestore.collection(MODEL_CONST
        .COLLECTION_ACCOUNT).doc(email).get();
      if (accountSnapshot.exists) {
        return fromFirestore(accountSnapshot);
      }
    }
    catch (e){
      return null;
    }
    return null;
  }
}