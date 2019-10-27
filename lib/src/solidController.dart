import 'package:flutter/foundation.dart';

import '../solid_bottom_sheet.dart';

class SolidController extends ValueNotifier<bool> {
  // This is the current height of the bottomSheet's body
  double height;

  // This is the current smoothness of the bottomSheet
  Smoothness smoothness;

  SolidController() : super(false);

  get isOpened => value;

  void hide() => value = false;

  void show() => value = true;
}
