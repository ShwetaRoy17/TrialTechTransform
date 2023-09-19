import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trialtechtransform_app/constants/global.var.dart';

class WalletService {
  void addMoneyToWalletInUtp(String utpId, int prev, int amt) async {
    await GlobalVars.store.collection("UnderTrial").doc(utpId).set({
      "balance": prev + amt,
    }, SetOptions(merge: true));
  }
}
