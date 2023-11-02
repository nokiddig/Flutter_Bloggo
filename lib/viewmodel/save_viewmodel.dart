import 'package:blog_app/model/save.dart';
import 'package:blog_app/services/save_account.dart';
import 'package:blog_app/viewmodel/viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/constain/firebase_model_const.dart';

class SaveViewmodel extends ViewModel<Save>{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final SaveViewmodel _instance = SaveViewmodel._internal();

  factory SaveViewmodel() {
    return _instance;
  }

  SaveViewmodel._internal();

  @override
  Future<void> add(Save t) async {
    await _firestore.collection(MODEL_CONST.COLLECTION_SAVE)
        .doc("${t.email},${t.blogId}")
        .set(convertToMap(t));
  }

  @override
  Map<String, dynamic> convertToMap(Save t) {
    return {
      MODEL_CONST.FIELD_BLOGID: t.blogId,
      MODEL_CONST.FIELD_EMAIL: t.email,
      MODEL_CONST.FIELD_TIME: t.timestamp
    };
  }

  @override
  Future<void> delete(String blogId) async {
    _firestore.collection(MODEL_CONST.COLLECTION_SAVE)
        .doc('${SaveAccount.currentEmail},$blogId').delete();
  }

  @override
  Future<void> edit(Save t) {
    // TODO: implement edit
    throw UnimplementedError();
  }

  @override
  Save fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Save(
      data[MODEL_CONST.FIELD_EMAIL],
      data[MODEL_CONST.FIELD_BLOGID],
      data[MODEL_CONST.FIELD_TIME],
    );
  }

  @override
  Future<List<Save>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  Stream<List<Save>> getByEmail() {
    return _firestore.collection(MODEL_CONST.COLLECTION_SAVE)
        .where(MODEL_CONST.FIELD_EMAIL,isEqualTo: SaveAccount.currentEmail)
        .orderBy(MODEL_CONST.FIELD_TIME, descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((e) {
            return fromFirestore(e);
          }).toList();
        });
  }
}