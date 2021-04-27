import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';

class BluetoothDeviceChecker extends StatefulWidget {
  
  @override
  _BluetoothDeviceCheckerState createState() => _BluetoothDeviceCheckerState();
}

class _BluetoothDeviceCheckerState extends State<BluetoothDeviceChecker> {
  int poolingTime;
  StreamSubscription<List<ScanResult>> subscriptionScan;
  Timer timer;

  Future<void> connectKnownDevices() async {
    
    print("Scanning devices");
    
    await FlutterBlue.instance.startScan(timeout: Duration(seconds: 2));

    subscriptionScan = 
    FlutterBlue.instance.scanResults.listen((bles) async {
          
      for (ScanResult ble in bles) {
        try{

          if(ble.device.name.isNotEmpty){
            await ble.device.connect();
          }
          
        }catch (errorBluetooth){
          print(errorBluetooth);
        }
        
      }
      
      subscriptionScan.cancel();
    });
    
  }

  @override
  initState() {
    poolingTime = 10;
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