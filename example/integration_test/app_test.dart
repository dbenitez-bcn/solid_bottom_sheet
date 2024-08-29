import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Solid bottom sheet', () {
    testWidgets('Should open and close when header is tapped',
            (tester) async {
          final header = find.byKey(const ValueKey('header'));
          await tester.pumpWidget(TestApp());
          expect(find.text("Body text").hitTestable(), findsNothing);

          await tester.tap(header);
          await tester.pumpAndSettle();
          expect(find.text("Body text").hitTestable(), findsOneWidget);

          await tester.tap(header);
          await tester.pumpAndSettle();
          expect(find.text("Body text").hitTestable(), findsNothing);
        });
    testWidgets('Should open and close when header is swipe',
            (tester) async {
          final header = find.byKey(const ValueKey('header'));

          await tester.pumpWidget(TestApp());
          expect(find.text("Body text").hitTestable(), findsNothing);

          await tester.drag(header, Offset(0, -50));
          await tester.pumpAndSettle();
          expect(find.text("Body text").hitTestable(), findsOneWidget);

          await tester.drag(header, Offset(0, 50));
          await tester.pumpAndSettle();
          expect(find.text("Body text").hitTestable(), findsNothing);
        });
  });
}


class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      home: TestHomePage(title: 'Test App Home Page'),
    );
  }
}

class TestHomePage extends StatefulWidget {
  TestHomePage({required this.title});

  final String title;

  @override
  _TestHomePageState createState() => _TestHomePageState();
}

class _TestHomePageState extends State<TestHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          'Testing Solid bottom sheet',
        ),
      ),
      bottomSheet: SolidBottomSheet(
        headerBar: Container(
          key: Key(("header")),
          color: Theme.of(context).primaryColor,
          height: 50,
          child: Center(
            child: Text("Swipe here"),
          ),
        ),
        body: Container(
          key: Key(("body")),
          color: Colors.white,
          height: 30,
          child: Center(
            child: Text(
              "Body text",
              key: Key(("text")),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),
        toggleVisibilityOnTap: true,
      ),
    );
  }
}
