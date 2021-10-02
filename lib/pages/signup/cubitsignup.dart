import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/module/user.dart';
import 'package:socialapp/pages/signup/signupState.dart';
import 'package:socialapp/shared/sharedwadget.dart';

class CubitSignup extends Cubit<SignupState> {
  CubitSignup() : super(InitLogState());

  static CubitSignup get(context) => BlocProvider.of(context);
  bool ispassword = false;
  void changevisiblepassword() {
    ispassword = !ispassword;
    emit(ChangepasswordState());
  }

  void usersignup(
      {required name, required email, required phone, required password}) {
    emit(SignupLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('done');
      toast(txt: value.user!.uid);
      userdata(uid: value.user!.uid, name: name, email: email, phone: phone);
    }).catchError((e) {
      print(e.toString());
      toast(txt: e.toString(), color: Colors.red).then((value) {
        emit(SignupFailState());
      });
    });
  }

  void userdata({required uid, required name, required email, required phone}) {
    SocialUserModel user1 =
        SocialUserModel(name: name, uId: uid, email: email, phone: phone);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(user1.toMap())
        .then((value) {
      emit(SignupSuccessState());
    }).catchError((e) {
      print(e.toString());
      toast(txt: e.toString(), color: Colors.red).then((value) {
        emit(SignupuserFailState());
      });
    });
  }
}
