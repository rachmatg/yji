import 'package:firebase_auth/firebase_auth.dart';

class AppState {
  bool isLoading;
  FirebaseUser user;
  String phoneNo;
  String smsCode;
  String verificationId;

  AppState({
    this.isLoading = false,
    this.user,
    this.phoneNo,
    this.smsCode,
    this.verificationId
  });

  factory AppState.loading() => new AppState(isLoading: true);

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, user: ${user?.displayName ?? 'null'}}';
  }
}