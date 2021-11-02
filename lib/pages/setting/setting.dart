import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/pages/setting/cubitsetting.dart';
import 'package:socialapp/pages/setting/settingState.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Cubitsetting()..getUserData(),
      child: BlocConsumer<Cubitsetting, SettingState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                body: Column(
              children: [
                Container(
                  height: 420,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: 400,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://www.bitebackpublishing.com/assets/fallback/square_default-6d6494494afb1ec313bd76a6b519e4e6.png'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0, left: 17.0),
                          child: Icon(Icons.arrow_back_ios, size: 30.0),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.camera_enhance,
                                size: 25,
                              )),
                        ),
                      )
                    ],
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${Cubitsetting.get(context).userModel!.name ?? 'No name'}'),
                                  Text('tap to change name',
                                      style: TextStyle(color: Colors.grey))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            InkWell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${Cubitsetting.get(context).userModel!.phone ?? 'No phone'}'),
                                  Text('tap to change phone',
                                      style: TextStyle(color: Colors.grey))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            InkWell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${Cubitsetting.get(context).userModel!.bio ?? 'Bio:'} '),
                                  Text('add a few words about yourself',
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                )
              ],
            ));
          }),
    );
  }
}
