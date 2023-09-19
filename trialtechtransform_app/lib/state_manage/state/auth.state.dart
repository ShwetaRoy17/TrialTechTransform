import 'package:trialtechtransform_app/models/user.model.dart';

class AuthState {}

class AuthInitialState extends AuthState {}

class AuthErrorState extends AuthState {
  String err;
  AuthErrorState({required this.err});
}

class AuthDoneState extends AuthState {
  UserModel user;
  AuthDoneState({required this.user});
}

class AuthLoadingState extends AuthState {}
