import 'package:flutter/material.dart';

import 'package:socialapp/shared/data.dart';

class Phone extends StatelessWidget {
  String? number2;
  Phone(this.number2);
  @override
  Widget build(BuildContext context) {
    final TextEditingController controlleText = TextEditingController();
    final GlobalKey<FormState> mainkey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Phone'),
        actions: [
          IconButton(
            onPressed: () {
              if (mainkey.currentState!.validate()) {
                phone = controlleText.text;
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
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hoverColor: Colors.blue,
                  hintText: '${number2 == null ? "No name" : number2}'),
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
