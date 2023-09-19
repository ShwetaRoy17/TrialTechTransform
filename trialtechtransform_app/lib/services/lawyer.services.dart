import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trialtechtransform_app/constants/global.var.dart';
import 'package:trialtechtransform_app/models/slot.model.dart';

class LawyerService {
  final FirebaseFirestore _store = GlobalVars.store;
  final FirebaseAuth _auth = GlobalVars.auth;

  void addSlot(DateTime dateTime, String day, String amount) async {
    await _store
        .collection("lawyer")
        .doc(_auth.currentUser!.uid)
        .collection("slots")
        .doc()
        .set({
      "date": Timestamp.fromDate(
        dateTime,
      ),
      "day": day,
      "occupied": false,
      "client": "",
      "fees": amount
    });
  }

  static List<SlotModel> bookedSlot = [];
  Future<List<SlotModel>> fetchBookedSlot() async {
    bookedSlot.clear();
    QuerySnapshot<Map<String, dynamic>> slots = await _store
        .collection("lawyer")
        .doc(_auth.currentUser!.uid)
        .collection("slots")
        .get();

    for (QueryDocumentSnapshot i in slots.docs) {
      if (i.get("occupied") == true) {
        print(i.id);
        bookedSlot.add(SlotModel(
            slotID: i.id,
            clientID: i.get("client"),
            lawyerid: _auth.currentUser!.uid,
            date: i.get("date"),
            day: i.get("day"),
            occupied: i.get("occupied"),
            slotAmt: i.get("fees")));
      }
    }

    return bookedSlot;
  }

  void cancelSlot(String lawyerID, String slotId, String utpId) async {
    await _store
        .collection("lawyer")
        .doc(lawyerID)
        .collection("slots")
        .doc(slotId)
        .set({
      "occupied": false,
      "client": "",
    }, SetOptions(merge: true));

    await _store.collection("UnderTrial").doc(utpId).set(
        {"bookedslot": false, "lawyer": "", "slotid": ""},
        SetOptions(merge: true));
  }

  void fetchAllSlots(String uid) async {
    print("here");
    QuerySnapshot<Map<String, dynamic>> mySlots =
        await _store.collection("lawyer").doc(uid).collection("slots").get();
    mySlots.docs.forEach((element) {
      Timestamp date = element.get("date");
      print(date.toDate().day);
    });
  }
}
