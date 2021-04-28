import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';

class BluetoothDeviceCharacteristict extends StatefulWidget {
  final BluetoothDevice device;

  const BluetoothDeviceCharacteristict({ Key key, this.device }): super(key: key);

  @override
  _BluetoothDeviceCharacteristict createState() => _BluetoothDeviceCharacteristict();
}

class _BluetoothDeviceCharacteristict extends State<BluetoothDeviceCharacteristict> {

  @override
  initState() async {
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

          return Text('# ${widget.device.name} - ${discoveredServices.data[2]}');
        }
      );
    });
    
  }
}