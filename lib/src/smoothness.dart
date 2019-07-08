class Smoothness {
  final int _value;

  Smoothness._() : _value = 0;

  const Smoothness._low() : _value = 100;

  const Smoothness._medium() : _value = 250;

  const Smoothness._high() : _value = 500;

  static const Smoothness low = Smoothness._low();
  static const Smoothness medium = Smoothness._medium();
  static const Smoothness high = Smoothness._high();

  int get value => _value;
}
