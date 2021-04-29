import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';

import 'bluetooth.device.data.dart';

class BluetoothDeviceCharacteristict extends StatefulWidget {
  final BluetoothDevice device;

  const BluetoothDeviceCharacteristict({ Key key, this.device }): super(key: key);

  @override
  _BluetoothDeviceCharacteristict createState() => _BluetoothDeviceCharacteristict();
}

class _BluetoothDeviceCharacteristict extends State<BluetoothDeviceCharacteristict> {

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
    
    return FutureBuilder(future: widget.device.discoverServices(), builder: (c, discoveredServices) {
      return StreamBuilder<List<BluetoothService>>(
        stream: widget.device.services,
        initialData: [],
        builder: (c, snapshot) {
          if(snapshot.data == null || snapshot.data.length == 0){
            return Text('Sem dispositivos conectados');
          }

          BluetoothService service = discoveredServices.data[2];
          BluetoothCharacteristic characteristics = service.characteristics[0];
          BluetoothCharacteristic characteristicsWrite  = service.characteristics[1];

          return Column(children: [
              Text('# ${widget.device.name}'),
              BluetoothDeviceData(characteristic: characteristics),
              FutureBuilder(future: characteristicsWrite.write(utf8.encode("ACK"), withoutResponse: true), builder: (cWrite, writeService) {
                print(cWrite);
                print(writeService);

                return Container(child: Text('Send Ack'));
              })
              
          ]);
          
        }
      );
    });
    
  }
}