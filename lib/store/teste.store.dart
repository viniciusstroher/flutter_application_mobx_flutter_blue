import 'package:flutter_application_mobx_flutter_blue/components/bluetooth.device.checker.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'teste.store.g.dart';

// This is the class used by rest of your codebase
class TesteStore = _TesteStore with _$TesteStore;

// The store-class
abstract class _TesteStore with Store {
  @observable
  int value = 0;

  @observable
  BluetoothDevice device;
  
  @action
  setDevice(BluetoothDevice newDevice){
    device = newDevice;
  }

  @action
  getDevice(){
    return device;
  }

  @action
  void increment() {
    value++;
  }
}
