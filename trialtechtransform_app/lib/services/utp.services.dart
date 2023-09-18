import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trialtechtransform_app/models/lawyer.model.dart';

import '../constants/global.var.dart';

class UtpService {
  final FirebaseFirestore _store = GlobalVars.store;
  final FirebaseAuth _auth = GlobalVars.auth;
  List<String> availLawyer = [];
  static List<LawyerModel> lawyers = [];

  Future<List<LawyerModel>> fetchLawyers(DateTime dateFilter) async {
    availLawyer.clear();
    lawyers.clear();
    QuerySnapshot<Map<String, dynamic>> alldocs =
        await _store.collection("lawyer").get();

    for (QueryDocumentSnapshot i in alldocs.docs) {
      // lawyer uid
      QuerySnapshot<Map<String, dynamic>> slots =
          await i.reference.collection("slots").get();
      for (QueryDocumentSnapshot j in slots.docs) {
        Timestamp dateOfSlot = j.get("date");
        if (dateOfSlot.toDate().isAfter(dateFilter) ||
            dateOfSlot.toDate().isAtSameMomentAs(dateFilter)) {
          if (!availLawyer.contains(i)) {
            availLawyer.add(i.id.toString());
            break;
          }
        }
      }
    }

    for (String i in availLawyer) {
      DocumentSnapshot<Map<String, dynamic>> lawyerDetails =
          await fetchLawyerDetailForUtp(i);
      lawyers.add(LawyerModel(
          lawyerUid: i.toString(),
          name: lawyerDetails.data()!["name"],
          phn: lawyerDetails.data()!["phone"]));
    }

    return lawyers;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchLawyerDetailForUtp(
      String uid) async {
    DocumentSnapshot<Map<String, dynamic>> lawyerData =
        await _store.collection("lawyer").doc(uid).get();

    return lawyerData;
  }

  void updateFirebaseForBookingSlot(String lawyerUid, String utpUid) async {
    await _store.collection("UnderTrial").doc(utpUid).set(
        {"bookedslot": true, "lawyer": lawyerUid}, SetOptions(merge: true));
    updateUTPintoLawyer(lawyerUid, utpUid);
  }

  void updateUTPintoLawyer(String lawyerUID, String utpUID) async {
    await _store
        .collection("lawyer")
        .doc(lawyerUID)
        .set({"gotClient": true, "client": utpUID}, SetOptions(merge: true));
  }
}
