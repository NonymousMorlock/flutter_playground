import 'package:flutter/cupertino.dart';

class Viewmodel<T> extends ChangeNotifier {
  Viewmodel(this._state);

  T _state;

  T get state => _state;

  void emit(T newState) {
    _state = newState;
    notifyListeners();
  }
}
