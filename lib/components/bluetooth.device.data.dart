import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';

class BluetoothDeviceData extends StatefulWidget {
  final BluetoothCharacteristic characteristic;

  const BluetoothDeviceData({ Key key, this.characteristic }): super(key: key);

  @override
  _BluetoothDeviceData createState() => _BluetoothDeviceData();
}

class _BluetoothDeviceData extends State<BluetoothDeviceData> {

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose()  {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: widget.characteristic.setNotifyValue(!widget.characteristic.isNotifying), builder: (c, characteristicService) {
      return StreamBuilder<List<int>>(
        stream: widget.characteristic.value,
        initialData: null,
        builder: (c, snapshot) {
          if(snapshot.data == null || snapshot.data.length == 0){
            return Text('no rx');
          }
          
          return Text(utf8.decode(snapshot.data));
        }
      );
    });                        
    
    
  }
}