import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trialtechtransform_app/models/lawyer.model.dart';
import 'package:trialtechtransform_app/models/slot.model.dart';

import '../constants/global.var.dart';

class UtpService {
  final FirebaseFirestore _store = GlobalVars.store;
  final FirebaseAuth _auth = GlobalVars.auth;
  List<String> availLawyer = [];
  static List<LawyerModel> lawyers = [];
  static List<SlotModel> slotsList = [];

  Future<String> getLawyerId(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> utp =
        await _store.collection("UnderTrial").doc(uid).get();

    String lawyerId = utp.get("lawyer");
    print(lawyerId + "this is lawyer");

    return lawyerId;
  }

  Future<List<SlotModel>> fetchLawyers(DateTime dateFilter) async {
    availLawyer.clear();
    lawyers.clear();
    slotsList.clear();
    QuerySnapshot<Map<String, dynamic>> alldocs =
        await _store.collection("lawyer").get();

    for (QueryDocumentSnapshot i in alldocs.docs) {
      // lawyer uid
      QuerySnapshot<Map<String, dynamic>> slots =
          await i.reference.collection("slots").get();
      for (QueryDocumentSnapshot j in slots.docs) {
        Timestamp dateOfSlot = j.get("date");
        String day = j.get("day");
        bool occupied = j.get("occupied");
        if (dateOfSlot.toDate().isAfter(dateFilter) ||
            dateOfSlot.toDate().isAtSameMomentAs(dateFilter)) {
          slotsList.add(SlotModel(
              slotID: j.id,
              clientID: "",
              lawyerid: i.id,
              date: dateOfSlot,
              day: day,
              occupied: occupied,
              slotAmt: j.get("fees")));
          // if (!availLawyer.contains(i)) {
          //   availLawyer.add(i.id.toString());
          //   break;
          // }
        }
      }
    }

    // for (String i in availLawyer) {
    //   DocumentSnapshot<Map<String, dynamic>> lawyerDetails =
    //       await fetchLawyerDetailForUtp(i);
    //   lawyers.add(LawyerModel(
    //       lawyerUid: i.toString(),
    //       name: lawyerDetails.data()!["name"],
    //       phn: lawyerDetails.data()!["phone"]));
    // }

    return slotsList;
  }

  Future<List<SlotModel>> fetchLawyersFilterDate(DateTime dateFilter) async {
    availLawyer.clear();
    lawyers.clear();
    slotsList.clear();
    QuerySnapshot<Map<String, dynamic>> alldocs =
        await _store.collection("lawyer").get();

    for (QueryDocumentSnapshot i in alldocs.docs) {
      // lawyer uid
      try {
        QuerySnapshot querySnapshot = await i.reference
            .collection("slots")
            .where('date',
                isGreaterThan: Timestamp.fromDate(dateFilter),
                isLessThan: DateTime(dateFilter.year, dateFilter.month,
                    dateFilter.day + 1, 0, 0))
            .get();

        // Iterate through the filtered documents
        querySnapshot.docs.forEach((DocumentSnapshot document) {
          print('Document ID: ${document.id}, Data: ${document.data()}');
        });
      } catch (e) {
        print('Error filtering documents: $e');
      }
    }

    // for (String i in availLawyer) {
    //   DocumentSnapshot<Map<String, dynamic>> lawyerDetails =
    //       await fetchLawyerDetailForUtp(i);
    //   lawyers.add(LawyerModel(
    //       lawyerUid: i.toString(),
    //       name: lawyerDetails.data()!["name"],
    //       phn: lawyerDetails.data()!["phone"]));
    // }

    return slotsList;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchLawyerDetailForUtp(
      String lawyerUid) async {
    DocumentSnapshot<Map<String, dynamic>> lawyerData =
        await _store.collection("lawyer").doc(lawyerUid).get();

    return lawyerData;
  }

  void updateFirebaseForBookingSlot(
      String lawyerUid, String utpUid, String slotId) async {
    await _store.collection("UnderTrial").doc(utpUid).set(
        {"bookedslot": true, "lawyer": lawyerUid, "slotid": slotId},
        SetOptions(merge: true));
    _updateUTPintoLawyer(lawyerUid, utpUid, slotId);
  }

  void _updateUTPintoLawyer(
      String lawyerUID, String utpUID, String slotId) async {
    await _store
        .collection("lawyer")
        .doc(lawyerUID)
        .collection("slots")
        .doc(slotId)
        .set({"occupied": true, "client": utpUID}, SetOptions(merge: true));
  }
}
