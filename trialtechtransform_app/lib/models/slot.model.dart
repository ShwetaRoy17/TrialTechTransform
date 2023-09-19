import 'package:cloud_firestore/cloud_firestore.dart';

class SlotModel {
  String slotID;
  String lawyerid;
  Timestamp date;
  String day;
  bool occupied;
  String clientID;
  String slotAmt;

  SlotModel(
      {required this.slotID,
      required this.clientID,
      required this.lawyerid,
      required this.date,
      required this.day,
      required this.occupied,
      required this.slotAmt});
}
