import 'package:flutter_test/flutter_test.dart';
import 'package:solid_bottom_sheet/src/solid_bloc.dart';

void main() {
  SolidBloc bloc;
  
  setUp(() {
    bloc = SolidBloc();
  });

  test('should emit the right values for height', () async {
    final expected = [0.0, 100.0, 150.0];

    expectLater(bloc.height, emitsInOrder(expected));

    bloc.dispatch(0.0);
    bloc.dispatch(100.0);
    bloc.dispatch(150.0);
  });


  test('should emit the right values for visibility', () {
    final expected = [false, true, false];

    expectLater(bloc.isOpen, emitsInOrder(expected));

    bloc.dispatch(0.0);
    bloc.dispatch(100.0);
    bloc.dispatch(0.0);
  });
}