import 'package:blog_app/model/comment.dart';
import 'package:blog_app/services/save_account.dart';
import 'package:blog_app/utils/constain/firebase_model_const.dart';
import 'package:blog_app/viewmodel/viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentViewmodel extends ViewModel<Comment>{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> genNewId() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection(MODEL_CONST.COLLECTION_COMMENT)
        .get();
    int id = 0;
    querySnapshot.docs.forEach((element) {
      if(id < int.parse(element.id)){
        id = int.parse(element.id);
      }
    });
    id ++;
    return id.toString();
  }

  @override
  Future<void> add(Comment t) async {
    t.id = await genNewId();
    await _firestore.collection(MODEL_CONST.COLLECTION_LIKE)
        .doc(t.id)
        .set(convertToMap(t));
  }

  @override
  Map<String, dynamic> convertToMap(Comment t) {
    return {
      MODEL_CONST.FIELD_CONTENT: t.content,
      MODEL_CONST.FIELD_EMAIL: t.email,
      MODEL_CONST.FIELD_TIME: t.time,
      MODEL_CONST.FIELD_BLOGID: t.blogId,
    };
  }

  @override
  Future<void> delete(String id) async {
    await _firestore
        .collection(MODEL_CONST.COLLECTION_COMMENT)
        .doc(id)
        .delete();
  }

  @override
  Future<void> edit(Comment t) {
    // TODO: implement edit
    throw UnimplementedError();
  }

  @override
  Comment fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Comment(
      doc.id,
      data[MODEL_CONST.FIELD_CONTENT],
      data[MODEL_CONST.FIELD_EMAIL],
      data[MODEL_CONST.FIELD_TIME],
      data[MODEL_CONST.FIELD_BLOGID]
    );
  }

  @override
  Future<List<Comment>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  Stream<List<Comment>> getByBlogId(String blogId) {
    return _firestore.collection(MODEL_CONST.COLLECTION_COMMENT)
        .where(MODEL_CONST.FIELD_BLOGID, isEqualTo: blogId)
        .snapshots().map((snap) => snap.docs.map((doc) => fromFirestore(doc)).toList());
  }

  Future<int> countComment(String blogId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection(MODEL_CONST.COLLECTION_LIKE)
        .where(MODEL_CONST.FIELD_BLOGID, isEqualTo: blogId)
        .get();
    return querySnapshot.size;
  }
}