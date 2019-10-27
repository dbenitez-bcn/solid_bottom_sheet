import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

void main() {
  group('Solid bottom sheet', () {
    final headerKey = Key("header");

    testWidgets('should open and close when tap', (WidgetTester tester) async {
      final SolidController controller = SolidController();
      final SolidBottomSheet bottomSheet = SolidBottomSheet(
        key: Key("solidFinder"),
        controller: controller,
        headerBar: Container(
          key: headerKey,
          height: 50,
          child: Center(
            child: Text("Swipe here"),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: 30,
          child: Center(
            child: Text(
              "Body text",
              key: Key("text"),
            ),
          ),
        ),
        toggleVisibilityOnTap: true,
      );
      final headerFinder = find.byKey(headerKey);
      final TestApp app = TestApp(bottomSheet);

      await tester.pumpWidget(app);
      await tapToToggle(tester, headerFinder);
      expect(controller.isOpened, isTrue);
      await tapToToggle(tester, headerFinder);
      expect(controller.isOpened, isFalse);
    });

    testWidgets('should open when drag up', (WidgetTester tester) async {
      final SolidController controller = SolidController();
      final SolidBottomSheet bottomSheet = SolidBottomSheet(
        key: Key("solidFinder"),
        controller: controller,
        headerBar: Container(
          key: headerKey,
          height: 50,
          child: Center(
            child: Text("Swipe here"),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: 30,
          child: Center(
            child: Text(
              "Body text",
              key: Key("text"),
            ),
          ),
        ),
      );
      final headerFinder = find.byKey(headerKey);
      final TestApp app = TestApp(bottomSheet);

      await tester.pumpWidget(app);
      await dragToOpen(tester, headerFinder);
      expect(controller.isOpened, isTrue);
    });

    testWidgets('should close when drag down', (WidgetTester tester) async {
      final SolidController controller = SolidController();
      final SolidBottomSheet bottomSheet = SolidBottomSheet(
        controller: controller,
        showOnAppear: true,
        headerBar: Container(
          key: headerKey,
          height: 50,
          child: Center(
            child: Text("Swipe here"),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: 30,
        ),
      );
      final headerFinder = find.byKey(headerKey);
      final TestApp app = TestApp(bottomSheet);

      await tester.pumpWidget(app);
      await dragToClose(tester, headerFinder);
      expect(controller.isOpened, isFalse);
    });

    testWidgets('should call onShow when is opened',
        (WidgetTester tester) async {
      int timesExecuted = 0;
      final SolidController controller = SolidController();
      final SolidBottomSheet bottomSheet = SolidBottomSheet(
        controller: controller,
        toggleVisibilityOnTap: true,
        onShow: () {
          timesExecuted++;
        },
        headerBar: Container(
          key: headerKey,
          height: 50,
          child: Center(
            child: Text("Swipe here"),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: 30,
        ),
      );
      final headerFinder = find.byKey(headerKey);
      final TestApp app = TestApp(bottomSheet);

      await tester.pumpWidget(app);
      await dragToOpen(tester, headerFinder);
      expect(timesExecuted, 1);
      await tapToToggle(tester, headerFinder);
      await tapToToggle(tester, headerFinder);
      expect(timesExecuted, 2);
      await tapToToggle(tester, headerFinder);
      controller.show();
      expect(timesExecuted, 3);
    });

    testWidgets('should call onHide when is closed',
        (WidgetTester tester) async {
      int timesExecuted = 0;
      final SolidController controller = SolidController();
      final SolidBottomSheet bottomSheet = SolidBottomSheet(
        controller: controller,
        toggleVisibilityOnTap: true,
        onHide: () {
          timesExecuted++;
        },
        headerBar: Container(
          key: headerKey,
          height: 50,
          child: Center(
            child: Text("Swipe here"),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: 30,
        ),
      );
      final headerFinder = find.byKey(headerKey);
      final TestApp app = TestApp(bottomSheet);

      await tester.pumpWidget(app);
      await tapToToggle(tester, headerFinder);
      await dragToClose(tester, headerFinder);
      expect(timesExecuted, 1);
      await tapToToggle(tester, headerFinder);
      await tapToToggle(tester, headerFinder);
      expect(timesExecuted, 2);
      await tapToToggle(tester, headerFinder);
      controller.hide();
      expect(timesExecuted, 3);
    });
  });
}

Future tapToToggle(WidgetTester tester, Finder headerFinder) async {
  await tester.tap(headerFinder);
  await tester.pump();
}

Future dragToClose(WidgetTester tester, Finder headerFinder) async {
  await tester.drag(headerFinder, Offset(0.0, 200.0));
  await tester.pump();
}

Future dragToOpen(WidgetTester tester, Finder headerFinder) async {
  await tester.drag(headerFinder, Offset(0.0, -200.0));
  await tester.pump();
}

class TestApp extends StatefulWidget {
  final SolidBottomSheet bottomSheet;

  TestApp(this.bottomSheet);

  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomSheet: widget.bottomSheet,
      ),
    );
  }
}
