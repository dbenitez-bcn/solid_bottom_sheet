// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter App', () {
    final textFinder = find.byValueKey('text');
    final headerFinder = find.byValueKey('header');
    final bodyFinder = find.byValueKey('body');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Should open when header is tapper', () async {
      await driver.tap(headerFinder);

      expect(await driver.getText(textFinder), "Body text");
    });
  });

  group('Counter App', () {
    final textFinder = find.byValueKey('text');
    final headerFinder = find.byValueKey('header');
    final bodyFinder = find.byValueKey('body');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Should open when header is scrolled up', () async {
      await driver.scroll(headerFinder, 0, -200, Duration(seconds: 1));
      expect(await driver.getText(textFinder), "Body text");
    });
  });
}
