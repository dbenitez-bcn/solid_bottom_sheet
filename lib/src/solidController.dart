import 'package:flutter/foundation.dart';

import '../solid_bottom_sheet.dart';

class SolidController extends ValueNotifier<bool> {
  // This is the current height of the bottomSheet's body
  double _height;

  // This is the current smoothness of the bottomSheet
  Smoothness _smoothness;

  SolidController() : super(false);

  get isOpened => value;

  double get height => _height;

  set height(double value) {
    _height = value;
  }

  Smoothness get smoothness => _smoothness;

  set smoothness(Smoothness value) {
    _smoothness = value;
  }

  void hide() => value = false;

  void show() => value = true;
}
