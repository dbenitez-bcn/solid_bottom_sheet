import 'package:flutter/material.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      home: MyHomePage(title: 'Counter App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
