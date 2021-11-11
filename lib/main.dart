import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/pages/mainchat/chat.dart';
import 'package:socialapp/pages/signin/login.dart';
import 'package:socialapp/shared/cache.dart';
import 'package:socialapp/shared/data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        home: uid == null ? Sign() : MainChat());
  }
}
