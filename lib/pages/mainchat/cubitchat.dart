import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/module/massage.dart';
import 'package:socialapp/module/user.dart';
import 'package:socialapp/pages/mainchat/chatstate.dart';
import 'package:socialapp/shared/cache.dart';
import 'package:socialapp/shared/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cubitchat extends Cubit<ChattingState> {
  Cubitchat() : super(InitChattingState());

  static Cubitchat get(context) => BlocProvider.of(context);

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

  List<SocialUserModel> allusers = [];
  void getalluser() {
    allusers = [];
    emit(SocialGetallUserLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != uId) {
          allusers.add(SocialUserModel.fromJson(element.data()));
        }
      });
    }).catchError((e) {});
  }

  List<MassageModel> massages = [];
  void getallmassage(otheruid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId!)
        .collection('chats')
        .doc(otheruid)
        .collection('messages')
        .orderBy('datetime')
        .snapshots()
        .listen((event) {
      massages = [];
      event.docs.forEach((element) {
        massages.add(MassageModel.fromJson(element.data()));
      });

      emit(SocialGetMessagesSuccessState());
    });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MassageModel model = MassageModel(
      text: text,
      senduid: uId ?? 'gk',
      receiveid: receiverId,
      datetime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageFailState());
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageFailState());
    });
  }
}
