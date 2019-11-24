import 'package:flutter/foundation.dart';
import 'package:solid_bottom_sheet/src/solid_bloc.dart';

import '../solid_bottom_sheet.dart';

class SolidController extends ValueNotifier<bool> {
  SolidBloc _bloc = SolidBloc();

  // This is the current height of the bottomSheet's body
  double _height;

  // This is the current smoothness of the bottomSheet
  Smoothness smoothness;

  SolidController() : super(false);

  // Returns the value of the height as stream
  Stream<double> get heightStream => _bloc.height;

  // Returns the value of the visibility as stream
  Stream<bool> get isOpenStream => _bloc.isOpen;

  // This method sets the value of the height using streams
  set height(double value) {
    _height = value;
    _bloc.dispatch(value);
  }

  // Returns the value of the height
  double get height => _height;

  //  Returns if the solid bottom sheet is opened or not
  bool get isOpened => value;

  // Updates the visibility value to false
  void hide() => value = false;

  // Updates the visibility value to true
  void show() => value = true;

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
