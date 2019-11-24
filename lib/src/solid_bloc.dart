import 'dart:async';

class SolidBloc {
  StreamController<double> _heightController =
      StreamController<double>.broadcast();
  Stream<double> get height => _heightController.stream;
  Sink<double> get _heightSink => _heightController.sink;

  StreamController<bool> _visibilityController =
      StreamController<bool>.broadcast();
  Stream<bool> get isOpen => _visibilityController.stream;
  Sink<bool> get _visibilitySink => _visibilityController.sink;

  // Adds new values to streams
  void dispatch(double value) {
    _heightSink.add(value);
    _visibilitySink.add(value > 0);
  }

  // Closes streams
  void dispose() {
    _heightController.close();
    _visibilityController.close();
  }
}
