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
      await _firestore.collection(ModelConst.COLLECTION_ACCOUNT).doc(account.email)
          .set(convertToMap(account));
    } catch (e) {
      print('Error: $e');
    }
  }

  Stream<List<Account>> getAll() {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot = _firestore.collection(ModelConst.COLLECTION_ACCOUNT).snapshots();
    if (snapshot.isEmpty == true) {

    }
    return _firestore.collection(ModelConst.COLLECTION_ACCOUNT).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Account user = Account.fromFirestore(doc);
        return user;
      }
      ).toList();
    });
  }

  Future<void> delete(String email) async {
    await _firestore.collection(ModelConst.COLLECTION_ACCOUNT).doc(email).delete();
  }

  Future<void> edit(Account account) async {
    await _firestore.collection(ModelConst.COLLECTION_ACCOUNT).doc(account.email)
        .set(convertToMap(account));
  }

  @override
  Map<String, dynamic> convertToMap(Account account){
    return {
      ModelConst.FIELD_AVATAR: account.avatarPath,
      ModelConst.FIELD_NAME: account.name,
      ModelConst.FIELD_GENDER: account.gender,
      ModelConst.FIELD_STATUS: account.status,
    };
  }

  @override
  Account fromFirestore(DocumentSnapshot<Object?> doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Account(
        data[ModelConst.FIELD_NAME],
        doc.id,
        data[ModelConst.FIELD_AVATAR],
        data[ModelConst.FIELD_STATUS],
        data[ModelConst.FIELD_GENDER]);
  }
}