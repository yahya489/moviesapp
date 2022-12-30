import 'package:flutter/material.dart';

class ButtonsProvider extends ChangeNotifier {
  bool isPressed = false;
  isPressedToggle() {
    isPressed = true;
    notifyListeners();
  }

  int? isPressedId = null;
  isPressedCheck(int isPressedCheckId) {
    isPressedId = isPressedCheckId;
    notifyListeners();
  }
}
