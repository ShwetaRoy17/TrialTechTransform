import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GlobalVars {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore store = FirebaseFirestore.instance;
}
