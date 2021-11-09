import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/pages/change/bio.dart';
import 'package:socialapp/pages/change/name.dart';
import 'package:socialapp/pages/change/number.dart';
import 'package:socialapp/pages/setting/cubitsetting.dart';
import 'package:socialapp/pages/setting/settingState.dart';
import 'package:socialapp/pages/signin/login.dart';
import 'package:socialapp/shared/data.dart';
import 'package:socialapp/shared/sharedwadget.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => Cubitsetting()..getUserData(), child: Settingapp());
  }
}

class Settingapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubitsetting, SettingState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Cubitsetting.get(context).userModel == null
              ? Center(child: CircularProgressIndicator())
              : Scaffold(
                  body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 420,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: (profileImage == null)
                                  ? Container(
                                      width: double.infinity,
                                      height: 400,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(Cubitsetting
                                                          .get(context)
                                                      .userModel!
                                                      .cover ??
                                                  'https://www.bitebackpublishing.com/assets/fallback/square_default-6d6494494afb1ec313bd76a6b519e4e6.png'),
                                              fit: BoxFit.cover)),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      height: 400,
                                      child: Image.file(
                                        profileImage!,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 30.0, left: 17.0),
                                child: Icon(Icons.arrow_back_ios, size: 30.0),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: InkWell(
                                  onTap: () {
                                    Cubitsetting.get(context).getProfileImage();
                                  },
                                  child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.blue,
                                      child: Icon(
                                        Icons.camera_enhance,
                                        size: 25,
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        elevation: 8.0,
                        child: Container(
                          color: Colors.grey[100],
                          width: double.infinity,
                          child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Account information',
                                      style: TextStyle(color: Colors.blue)),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      navigateto(
                                          context: context,
                                          widget: Name(Cubitsetting.get(context)
                                              .userModel!
                                              .name));
                                      /*  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return BlocProvider.value(
                                              value: Cubitsetting(),
                                              child: Name(
                                                  Cubitsetting.get(context)
                                                      .userModel!
                                                      .name),
                                            );
                                          },
                                        ),
                                      );
                                  */
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${name ?? (Cubitsetting.get(context).userModel!.name ?? "No name")}'),
                                        Text('tap to change name',
                                            style:
                                                TextStyle(color: Colors.grey))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      navigateto(
                                          context: context,
                                          widget: Phone(
                                              Cubitsetting.get(context)
                                                  .userModel!
                                                  .phone));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${phone ?? (Cubitsetting.get(context).userModel!.phone ?? "No phone")}'),
                                        Text('tap to change phone',
                                            style:
                                                TextStyle(color: Colors.grey))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      navigateto(
                                          context: context,
                                          widget: Bio(Cubitsetting.get(context)
                                              .userModel!
                                              .bio));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${bio ?? (Cubitsetting.get(context).userModel!.bio ?? "Bio:")} '),
                                        Text('add a few words about yourself',
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                      Card(
                        elevation: 8.0,
                        child: Container(
                          color: Colors.grey[100],
                          width: double.infinity,
                          child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Account information',
                                      style: TextStyle(color: Colors.blue)),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.notification_add),
                                        Text('notification setting'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.lock),
                                        Text('privacy and security'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print(name);
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.chat_bubble),
                                        Text('chat setting'),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 15.0,
                          left: 15.0,
                          top: 5.0,
                          bottom: 5.0,
                        ),
                        child: defaultButton(
                            radius: 10,
                            function: () {
                              Cubitsetting.get(context).update();
                            },
                            text: 'update data'),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                            right: 15.0,
                            left: 15.0,
                            top: 5.0,
                            bottom: 5.0,
                          ),
                          child: defaultButton(
                              radius: 10,
                              background: Colors.red,
                              function: () {
                                Cubitsetting.get(context).logout();
                                navigateto(context: context, widget: Sign());
                              },
                              text: 'logout')),
                    ],
                  ),
                ));
        });
  }
}
