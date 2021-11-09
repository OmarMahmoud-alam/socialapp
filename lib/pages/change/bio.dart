import 'package:flutter/material.dart';

import 'package:socialapp/shared/data.dart';

class Bio extends StatelessWidget {
  String? bio2;
  Bio(this.bio2);
  @override
  Widget build(BuildContext context) {
    final TextEditingController controlleText = TextEditingController();
    final GlobalKey<FormState> mainkey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Bio'),
        actions: [
          IconButton(
            onPressed: () {
              if (mainkey.currentState!.validate()) {
                bio = controlleText.text;
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
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hoverColor: Colors.blue,
                  hintText: '${bio2 == null ? "No name" : bio2}'),
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
