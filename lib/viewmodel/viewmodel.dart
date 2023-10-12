import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ViewModel<T>{
  T fromFirestore(DocumentSnapshot doc);
  Map<String, dynamic> convertToMap(T t);
  Future<void> add(T t);
  Stream<List<T>> getAll();
  Future<void> delete(String str);
  Future<void> edit(T t);
}