import 'package:flutter/material.dart';

import 'package:socialapp/shared/data.dart';

class Name extends StatelessWidget {
  String? name2;
  Name(this.name2);
  @override
  Widget build(BuildContext context) {
    final TextEditingController controlleText = TextEditingController();
    final GlobalKey<FormState> mainkey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Name'),
        actions: [
          IconButton(
            onPressed: () {
              if (mainkey.currentState!.validate()) {
                name = controlleText.text;
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.check_box),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          child: Form(
            key: mainkey,
            child: TextFormField(
              controller: controlleText,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hoverColor: Colors.blue,
                  hintText: '${name2 == null ? "No name" : name2}'),
              validator: (String? s) {
                if (s == null || s == '') {
                  return 'must enter value';
                } else
                  return null;
              },
            ),
          ),
        ),
      ),
    );
  }
}
