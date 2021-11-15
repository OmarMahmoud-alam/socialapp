import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/pages/learn.dart';
import 'package:socialapp/pages/mainchat/chat.dart';
import 'package:socialapp/pages/signin/login.dart';
import 'package:socialapp/shared/cache.dart';
import 'package:socialapp/shared/data.dart';
import 'package:socialapp/shared/sharedwadget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();

  print(token);

  // foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());

    toast(txt: 'on massage');
  });

  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());
    toast(txt: 'on massage');
  });

  // background fcm
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'UserUid');
  runApp(MyApp(uId));
}

class MyApp extends StatelessWidget {
  String? uid;
  MyApp(this.uid);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Nativeplate());
  }
}
