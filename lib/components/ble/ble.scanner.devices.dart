import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BleScannerDevices extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<List<ScanResult>>(
        stream: FlutterBlue.instance.scanResults,
        initialData: [],
        builder: (c, snapshot) {
          return Text(snapshot.data.toString());
          // if(snapshot.data != null && snapshot.data.length > 0){
          //   BluetoothDevice device;
          //   for (ScanResult result in snapshot.data) {
          //     if(result.device.name.contains("Time")){
          //       device = result.device;
          //       break;
          //     }
          //   }
          

          //   return StreamBuilder<BluetoothDeviceState>(
          //     stream: device.state,
          //     initialData: BluetoothDeviceState.disconnected,
          //     builder: (c, snapshot) {
          //       switch(snapshot.data){
          //         case BluetoothDeviceState.disconnected:
          //           device.connect(autoConnect: false);
          //           return Text('Connecting...');
          //         break;
          //         default:
          //           return Text('Connected.');
          //         break;
          //       }
          //     }
          //   );
          // }
          // return Text('...');
        }
    );
  }
}