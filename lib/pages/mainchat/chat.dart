import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/pages/chatdetials/chatdetial.dart';
import 'package:socialapp/pages/mainchat/chatstate.dart';
import 'package:socialapp/pages/mainchat/cubitchat.dart';
import 'package:socialapp/pages/setting/setting.dart';
import 'package:socialapp/shared/data.dart';
import 'package:socialapp/shared/sharedwadget.dart';

class MainChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Cubitchat()
        ..getUserData()
        ..getalluser(),
      child: BlocConsumer<Cubitchat, ChattingState>(
          listener: (context, state) {},
          builder: (context, state) {
            return userModel == null ||
                    Cubitchat.get(context).allusers.length == 0
                ? Center(child: CircularProgressIndicator())
                : Scaffold(
                    appBar: AppBar(
                      title: Text("Let\'s chat"),
                      leading: IconButton(
                        onPressed: () {
                          navigateto(context: context, widget: Setting());
                        },
                        icon: Icon(
                          Icons.settings,
                        ),
                      ),
                      actions: [
                        Icon(Icons.search_rounded),
                        SizedBox(
                          width: 10.0,
                        )
                      ],
                    ),
                    body: ListView.separated(
                        itemBuilder: (context, index) => personchat(
                            Cubitchat.get(context).allusers[index], context),
                        separatorBuilder: (context, index) => sepp(),
                        itemCount: Cubitchat.get(context).allusers.length));
          }),
    );
  }
}

Widget personchat(user, context) => InkWell(
      onTap: () {
        navigateto(context: context, widget: ChatD(user));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                '${user.cover ?? "https://www.bitebackpublishing.com/assets/fallback/square_default-6d6494494afb1ec313bd76a6b519e4e6.png"}',
              )),
          SizedBox(
            width: 10.0,
          ),
          Text(
            '${user!.name}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ]),
      ),
    );
Widget sepp() => Container(
    width: double.infinity,
    height: 0.5,
    margin: EdgeInsets.only(left: 60.0, right: 5.0),
    color: Colors.black);
