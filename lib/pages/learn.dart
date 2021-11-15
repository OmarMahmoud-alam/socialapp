import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Nativeplate extends StatefulWidget {
  @override
  _NativeplateState createState() => _NativeplateState();
}

class _NativeplateState extends State<Nativeplate> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Unknown battery level.';

  void _getBatteryLevel() {
    String batteryLevel = "dasdad";

    platform.invokeMethod('getBatteryLevel').then((value) {
      batteryLevel = 'Battery level at $value % .';
    }).catchError((e) {
      batteryLevel = 'error battery $e % .';
    });

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            child: Text('Get Battery Level'),
            onPressed: _getBatteryLevel,
          ),
          Text(_batteryLevel),
        ],
      ),
    );
  }
}
