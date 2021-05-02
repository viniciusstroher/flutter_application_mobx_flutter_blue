import 'package:flutter/widgets.dart';
import 'package:flutter_application_mobx_flutter_blue/store/teste.store.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';

import 'bluetooth.device.characterist.dart';

class BluetoothDeviceChecker extends StatefulWidget {
  
  @override
  _BluetoothDeviceCheckerState createState() => _BluetoothDeviceCheckerState();
}

class _BluetoothDeviceCheckerState extends State<BluetoothDeviceChecker> {
  final store = TesteStore();
  
  int poolingTime;
  StreamSubscription<List<ScanResult>> subscriptionScan;
  Timer timer;

  Future<void> connectKnownDevices() async {
    
    print("Scanning devices");
    
    await FlutterBlue.instance.startScan(timeout: Duration(seconds: 2));

    subscriptionScan = 
    FlutterBlue.instance.scanResults.listen((bles) async {
      List<BluetoothDevice> bleDevicesConnected = await FlutterBlue.instance.connectedDevices;      

      for (ScanResult ble in bles) {
        try{
          BluetoothDevice device = store.getDevice();
          // não pode ter dispositivos conectados
          if(ble.device.name.isNotEmpty && bleDevicesConnected.length == 0){
            // adicionar ao mobx o dispositivo adicionado
            // await ble.device.disconnect();
            store.setDevice(ble.device);
            await ble.device.connect(autoConnect: false);
          }
          
        } on Exception catch (errorBluetooth) {
          print(errorBluetooth);
        }
        
      }
      subscriptionScan.cancel();
    });
  }

  @override
  initState() {
    poolingTime = 20;
    timer = new Timer.periodic(Duration(seconds: poolingTime), (Timer t) async => await connectKnownDevices());
    
    super.initState();
  }

  @override
  void dispose(){
    if(subscriptionScan != null){
      subscriptionScan.cancel();
    }

    if(timer != null){
      timer.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
              children: [
                StreamBuilder<List<BluetoothDevice>>(
                  stream: Stream.periodic(Duration(seconds: 10))
                            .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                  initialData: [],
                  builder: (c, snapshot) {
                    if(snapshot.data == null || snapshot.data.length == 0){
                      return Text('Sem dispositivos conectados');
                    }

                    return Column(children: snapshot.data.map((device) => BluetoothDeviceCharacteristict(device: device) ).toList());
                  }
                )
              ],
            ),
          );
  }
}