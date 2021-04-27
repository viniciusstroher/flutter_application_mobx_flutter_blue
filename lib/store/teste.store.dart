import 'package:mobx/mobx.dart';

// Include generated file
part 'teste.store.g.dart';

// This is the class used by rest of your codebase
class TesteStore = _TesteStore with _$TesteStore;

// The store-class
abstract class _TesteStore with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
