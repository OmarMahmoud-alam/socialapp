import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
//import 'web_H.dart';
//import '../colab/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  InputBorder border = const OutlineInputBorder(),
  ValueChanged<String>? onChange,
  GestureTapCallback? onTap,
  bool isPassword = false,
  required FormFieldValidator<String> validate,
  String? label,
  String? hint,
  IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label ?? null,
        hintText: hint ?? null,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: border,
      ),
    );
Future<bool?> toast({
  required String txt,
  color = Colors.red,
  time = 1,
}) {
  return Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: time,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

/* 
Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'done',
                  id: model['id'],
                );
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'archive',
                  id: model['id'],
                );
              },
              icon: Icon(
                Icons.archive,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(
          id: model['id'],
        );
      },
    ); */

Widget conditionbuild({context, required Widget widget, condition = true}) {
  return Conditional.single(
      context: context,
      conditionBuilder: (BuildContext context) => condition,
      widgetBuilder: (context) => widget,
      fallbackBuilder: (BuildContext context) =>
          Center(child: CircularProgressIndicator()));
}

/*
       return Conditional.single(
      context: context,
      conditionBuilder: (BuildContext context) =>Condition,
      widgetBuilder: (BuildContext context) => widget,
      fallbackBuilder: (BuildContext context) =>
          Center(child: CircularProgressIndicator()));
}/*
Widget tasksBuilder({
  @required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          return buildTaskItem(tasks[index], context);
        },
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
 */ /* 
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildArticleItem(article, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          navigateto(
              context: context,
              widget: WebSite2(
                url: article['url'],
              ));
          // Navigator.push(context, MaterialPageRoute(builder: (context) => W));
        },
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                image: DecorationImage(
                  // '${article["urlToImage"] == Null ? "http://placehold.it/250x250?fbclid=IwAR1KgirYAjPKfQ2YwNbSKzFAz37xbrlQXB2heQA9Oe1zAJLDLLs1npI0d1o" : article["urlToImage"].toString()} '
                  image: NetworkImage(article["urlToImage"] == null
                      ? "http://placehold.it/250x250?fbclid=IwAR1KgirYAjPKfQ2YwNbSKzFAz37xbrlQXB2heQA9Oe1zAJLDLLs1npI0d1o"
                      : article["urlToImage"].toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(list, {context}) {
  return Conditional.single(
      context: context,
      conditionBuilder: (BuildContext context) => list.length > 0,
      widgetBuilder: (BuildContext context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildArticleItem(list[index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: list.length,
          ),
      fallbackBuilder: (BuildContext context) =>
          Center(child: CircularProgressIndicator()));
}
 */*/
Future<dynamic> navigateto({required context, required Widget widget}) async =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
