import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';
import 'bluetooth.device.checker.dart';

class BluetoothChipChecker extends StatefulWidget {
  @override
  _BluetoothChipCheckerState createState() => _BluetoothChipCheckerState();
}

class _BluetoothChipCheckerState extends State<BluetoothChipChecker> {
  int poolingSeconds = 10;

  Stream<bool> stream; 

  @override
  initState() {
    super.initState();
    stream = Stream.periodic(Duration(seconds: poolingSeconds)).asyncMap((_) async {
      bool available = await FlutterBlue.instance.isAvailable;
      bool on = await FlutterBlue.instance.isOn;
      return available && on;
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
              children: [
                StreamBuilder<bool>(
                  stream: stream,
                  initialData: false,
                  builder: (c, snapshot) {
                    
                    if (snapshot.hasData) {
                      if(snapshot.data){
                        return BluetoothDeviceChecker();
                      }
                    }

                    return CircularProgressIndicator();
                  }
                )
              ],
            ),
          );
  }
}