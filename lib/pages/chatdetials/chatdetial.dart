import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/module/massage.dart';
import 'package:socialapp/module/user.dart';
import 'package:socialapp/pages/mainchat/chatstate.dart';
import 'package:socialapp/pages/mainchat/cubitchat.dart';
import 'package:socialapp/shared/data.dart';
import 'package:socialapp/shared/sharedwadget.dart';

class ChatD extends StatelessWidget {
  final TextEditingController massagecontroller = TextEditingController();

  SocialUserModel? user;
  ChatD(this.user);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => Cubitchat()
          ..getallmassage(user!.uId)
          ..getUserData()
          ..getalluser(),
        child: BlocConsumer<Cubitchat, ChattingState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  toolbarHeight: 60.0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  title: Row(
                    children: [
                      CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(
                            '${user!.cover ?? "https://www.bitebackpublishing.com/assets/fallback/square_default-6d6494494afb1ec313bd76a6b519e4e6.png"}',
                          )),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        '${user!.name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  actions: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.call),
                    SizedBox(
                      width: 14,
                    ),
                    Icon(Icons.three_p_rounded),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              MassageModel tempmassage =
                                  Cubitchat.get(context).massages[index];
                              if (tempmassage.senduid == uId)
                                return mymassage(tempmassage.text);
                              return othermassage(tempmassage.text);
                            },
                            separatorBuilder: (context, index) => Container(),
                            itemCount: Cubitchat.get(context).massages.length))

                    //  Text('sdasdasdasda')
                    ,
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        height: 55,
                        child: Row(
                          children: [
                            Expanded(
                              child: defaultFormField(
                                hint: 'type the text here......',
                                controller: massagecontroller,
                                type: TextInputType.text,
                                validate: (String? s) {
                                  if (s == null || s == '') {
                                    return 'must enter value';
                                  } else
                                    return null;
                                },
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15))),
                                height: 55,
                                child: IconButton(
                                    onPressed: () {
                                      Cubitchat.get(context).sendMessage(
                                          receiverId: user!.uId ?? 'dasd',
                                          dateTime: DateTime.now().toString(),
                                          text: massagecontroller.text);
                                      massagecontroller.text = '';
                                    },
                                    icon: Icon(Icons.send_outlined)))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}

othermassage(text) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 20.0),
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0))),
            child: Text(text),
          )),
    );
mymassage(text) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
          padding: const EdgeInsets.only(top: 25, right: 20.0),
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.lightBlue.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0))),
            child: Text(text),
          )),
    );
