import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/module/user.dart';
import 'package:socialapp/pages/setting/settingState.dart';
import 'package:socialapp/shared/cache.dart';

class Cubitsetting extends Cubit<SettingState> {
  Cubitsetting() : super(InitSettingState());

  static Cubitsetting get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;
  late String uId;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    uId = CacheHelper.getData(key: 'UserUid');
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      //print(value.data());
      userModel = SocialUserModel.fromJson(value.data());
      print(userModel!.name);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserFailState());
    });
  }
}
