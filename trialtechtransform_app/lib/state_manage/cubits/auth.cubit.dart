import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trialtechtransform_app/constants/global.var.dart';
import 'package:trialtechtransform_app/models/user.model.dart';
import 'package:trialtechtransform_app/services/auth.service.dart';
import 'package:trialtechtransform_app/state_manage/state/auth.state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  FirebaseAuth _auth = GlobalVars.auth;
  String? _verificationID;

  void sendOtp(String phn, String role, String name, bool create) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91$phn",
      codeSent: (verificationId, forceResendingToken) {
        _verificationID = verificationId;
      },
      verificationCompleted: (PhoneAuthCredential credential) {
        signInPhone(credential, role, name, create);
      },
      verificationFailed: (FirebaseAuthException err) {
        emit(AuthErrorState(err: err.message.toString()));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationID = verificationId;
      },
    );
  }

  void verifyOtp(String otp, String role, String name, bool create) async {
    emit(AuthLoadingState());
    PhoneAuthCredential cred = PhoneAuthProvider.credential(
        verificationId: _verificationID!, smsCode: otp);
    signInPhone(cred, role, name, create);
  }

  void signInPhone(PhoneAuthCredential credential, String role, String name,
      bool create) async {
    try {
      UserCredential user = await _auth.signInWithCredential(credential);
      if (user != null) {
        UserModel userModel = UserModel(
            uid: user.user!.uid,
            phn: user.user!.phoneNumber.toString(),
            role: role);
        if (create) {
          if (role == "UnderTrial") {
            await AuthService()
                .updateFirestoreInfoUtp(userModel.uid, userModel.phn, name);
          } else {
            await AuthService()
                .updateFirestoreInfoLawyer(userModel.uid, userModel.phn, name);
          }
        }

        emit(AuthDoneState(user: userModel));
      } else {
        emit(AuthErrorState(err: "User is not defined"));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(err: e.message.toString()));
    }
  }
}
