import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';
import 'bluetooth.device.checker.dart';

class BluetoothChipChecker extends StatelessWidget {
  final poolingSeconds = 10;
  
  @override
  Widget build(BuildContext context) {
    Stream<bool> stream = Stream.periodic(Duration(seconds: poolingSeconds)).asyncMap((_) async {
      bool available = await FlutterBlue.instance.isAvailable;
      bool on = await FlutterBlue.instance.isOn;
      return available && on;
    });

    return Container(
      child: Column(
              children: [
                StreamBuilder<bool>(
                  stream: stream,
                  // stream: Stream.fromFuture(isBluetoothAvailable()),
                  initialData: false,
                  builder: (c, snapshot) {
                    if (snapshot.hasData) {
                      if(snapshot.data){
                        return BluetoothDeviceChecker();
                      }
                    }
                    return CircularProgressIndicator();
                    // children: snapshot.data == null || snapshot.data.length == 0 ? 
                    //           [Text('Sem dispositivos conectados')] : 
                    //           snapshot.data.map((device) => Text('#${device.name}')).toList()
                  }
                )
              ],
            ),
          );
  }
  
}