import 'package:flutter/foundation.dart';

class SolidController extends ValueNotifier<bool> {
  SolidController() : super(false);

  get isOpened => value;

  void hide() => value = false;

  void show() => value = true;
}
