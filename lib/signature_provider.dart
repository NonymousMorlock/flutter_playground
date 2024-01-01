// coverage:ignore-file
import 'dart:async';

import 'package:flutter/material.dart';

class SignatureProvider extends ChangeNotifier {
  bool get isSigned => signature != null;

  String? signature;


  bool _signatureIsEmpty = true;

  bool get signatureIsEmpty => _signatureIsEmpty;


  void setSignatureEmpty() {
    _signatureIsEmpty = true;
    notifyListeners();
  }

  void setSignatureFilled() {
    _signatureIsEmpty = false;
    notifyListeners();
  }


  void setSigned(String signature, {bool notify = true}) {
    this.signature = signature;
    if (notify) notifyListeners();
  }

  void setUnsigned() {
    signature = null;
    notifyListeners();
  }

}
