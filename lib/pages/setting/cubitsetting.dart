import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/module/user.dart';
import 'package:socialapp/pages/setting/settingState.dart';
import 'package:socialapp/shared/cache.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:socialapp/shared/data.dart';
import 'package:socialapp/shared/sharedwadget.dart';

class Cubitsetting extends Cubit<SettingState> {
  Cubitsetting() : super(InitSettingState());

  static Cubitsetting get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;

  var picker = ImagePicker();

  var cover;

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState1());
    }
  }

  void update() {
    if (profileImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          cover = value;
          updateUser();
        }).catchError((e) {
          print(e.toString());
          emit(SocialProfileImagePickedErrorState2());
        });
      });
    } else {
      updateUser();
    }
  }

  void updateUser() {
    SocialUserModel modelupdate = SocialUserModel(
      name: name ?? userModel!.name,
      phone: phone ?? userModel!.phone,
      bio: bio ?? userModel!.bio,
      email: email ?? userModel!.email,
      cover: cover ?? userModel!.cover,
      uId: userModel!.uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(modelupdate.toMap())
        .then((value) {
      getUserData();
      toast(txt: 'update success');
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  void getUserData() {
    emit(SocialGetUserLoadingState());
    if (name != null) print(name);
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

  void logout() {
    CacheHelper.removeData(key: 'UserUid');
    toast(txt: 'Logout done');
  }
}
