import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/pages/signin/loginState.dart';
import 'package:socialapp/shared/sharedwadget.dart';
import 'package:socialapp/shared/cache.dart';

class CubitLogin extends Cubit<LoginState> {
  CubitLogin() : super(InitLogState());

  static CubitLogin get(context) => BlocProvider.of(context);
  bool ispassword = false;
  void changevisiblepassword() {
    ispassword = !ispassword;
    emit(ChangepasswordState());
  }

  void userLogin({required email, required password}) {
    emit((SocialLoginLoadingState()));
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.uid);
      toast(txt: value.user!.email ?? 'error');
      CacheHelper.saveData( key: 'UserUid', value: value.user!.uid);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((e) {
      print(e.toString());
      emit(SocialLoginFailState());
    });
  }
}
