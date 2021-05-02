import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BleConnectedDevices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BluetoothDevice>>(
        future: FlutterBlue.instance.connectedDevices,
        initialData: [],
        builder: (c, snapshot) {
          return Text(snapshot.data.toString());
        }
    );

    // return StreamBuilder<List<BluetoothDevice>>(
    //     stream: FlutterBlue.instance.connectedDevices,
    //     initialData: [],
    //     builder: (c, snapshot) {
          
    //     }
    // );
  }
}