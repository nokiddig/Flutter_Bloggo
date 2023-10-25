import 'package:cloud_firestore/cloud_firestore.dart';

class CustomData{
  DateTime convertTimestampDateTime(Timestamp time){
    return time.toDate();
  }
  Timestamp convertDateTimeTimestamp(DateTime time){
    return Timestamp.fromDate(time);
  }
}