import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trialtechtransform_app/constants/global.var.dart';
import 'package:trialtechtransform_app/views/authview/auth.view.dart';

class AuthService {
  final FirebaseAuth _auth = GlobalVars.auth;
  final FirebaseFirestore _store = GlobalVars.store;

  void signOut(BuildContext context) async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AuthView()), (route) => false);
    await GlobalVars.auth.signOut();
  }

  Future<bool> checkUTP(String phn) async {
    final d1 = await _store.collection("UnderTrial").get();
    for (int i = 0; i < d1.docs.length; i++) {
      if (d1.docs[i].get("phone") == phn) {
        return true;
      }
    }

    return false;
  }

  Future<bool> checkLawyer(String phn) async {
    final d2 = await _store.collection("lawyer").get();
    for (int i = 0; i < d2.docs.length; i++) {
      if (d2.docs[i].get("phone") == phn) {
        return true;
      }
    }

    return false;
  }

  updateFirestoreInfoUtp(String uid, String phn, String name) async {
    await _auth.currentUser!.updateDisplayName(name);
    await _store.collection("UnderTrial").doc(uid).set(
        {"phone": phn, "name": name, "bookedslot": false, "balance": 0},
        SetOptions(merge: true));
  }

  updateFirestoreInfoLawyer(String uid, String phn, String name) async {
    await _auth.currentUser!.updateDisplayName(name);
    await _store.collection("lawyer").doc(uid).set({
      "phone": phn,
      "name": name,
      "email": "",
      "exp": "",
      "courtname": "",
      "practiseArea": "",
      "LawSchool": ""
    }, SetOptions(merge: true));
  }
}
