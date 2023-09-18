import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trialtechtransform_app/constants/global.var.dart';

class LawyerService {
  final FirebaseFirestore _store = GlobalVars.store;
  final FirebaseAuth _auth = GlobalVars.auth;

  Map timeOfDayToFirebase(TimeOfDay timeOfDay) {
    return {'hour': timeOfDay.hour, 'minute': timeOfDay.minute};
  }

  TimeOfDay firebaseToTimeOfDay(Map data) {
    return TimeOfDay(hour: data['hour'], minute: data['minute']);
  }

  void addSlot(DateTime dateTime, String day) async {
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
      "client": ""
    });
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
