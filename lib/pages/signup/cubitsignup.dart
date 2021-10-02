import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      print(value.user!.uid);
      toast(txt: value.user!.uid);
      emit(SignupSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SignupFailState());
    });
  }
}
