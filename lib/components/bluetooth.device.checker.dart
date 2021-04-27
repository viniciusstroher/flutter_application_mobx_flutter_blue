import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';

class BluetoothDeviceChecker extends StatelessWidget {
  
  Future<void> connectKnownDevices() async {
    await FlutterBlue.instance.startScan(timeout: Duration(seconds: 2));
    print("Scanning devices");
    FlutterBlue.instance.scanResults.listen((results) async {
      // List<BluetoothDevice> devices = new List<BluetoothDevice>.of([]);
      for (ScanResult result in results) {
        try{
          // print(BluetoothDeviceState.values);
          
          if(result.device.name.isNotEmpty){
            await result.device.connect();
          }

          await FlutterBlue.instance.stopScan();
        }catch (errorBluetooth){
          print(errorBluetooth);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const fiveSeconds = const Duration(seconds: 10);
    new Timer.periodic(fiveSeconds, (Timer t) async => await connectKnownDevices());

    // connectKnownDevices
    return Container(
      child: Column(
              children: [
                // StreamBuilder(
                //   stream: Stream.periodic(Duration(seconds: 5), (x) async => await connectKnownDevices() ), 
                //   builder: (context, snapshot) {  
                //     return Container();
                //   },),
                StreamBuilder<List<BluetoothDevice>>(
                  stream: Stream.periodic(Duration(seconds: 10))
                            .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                  initialData: [],
                  builder: (c, snapshot) => Column(
                    children: snapshot.data == null || snapshot.data.length == 0 ? 
                              [Text('Sem dispositivos conectados')] : 
                              snapshot.data.map((device) => Text('#${device.name}')).toList()
                  )
                )
              ],
            ),
          );
  }
  
}