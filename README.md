# Solid bottom sheet

 A full customizable bottom sheet easy to implement. Just put it on your bottomSheet property on your Scaffold widget and see the magic. For more details see the README.md. Feel free to contribute. This package is open to recieve pull request on github. Enjoy! :D

## Screenshots

<img src="https://github.com/dbenitez-bcn/solid_bottom_sheet/blob/master/simple.gif" height="500em"><img src="https://github.com/dbenitez-bcn/solid_bottom_sheet/blob/master/fixed.gif" height="500em">

## Usage

```
SolidBottomSheet(
        headerBar: Container(), // Your header here
        body: Container(), // Your body here
      ),
```

## Properties
```dart
  // This controls the minimum height of the body. Must be greater or equal of 0.
  // By default is 0
  final double minHeight;

  // This controls the minimum height of the body. By default is 500
  final double maxHeight;

  // This is the content that will be hided of your bottomSheet. You can fit any
  // widget. This parameter is required
  final Widget body;

  // This is the header of your bottomSheet. This widget is the swipeable area
  // where user will interact. This parameter is required
  final Widget headerBar;

  // This flag is used to enable the automatic swipe of the bar. If it's true
  // the bottomSheet will automatically appear or disappear when user stops
  // swiping, but if it's false, it will stay at the last user finger position.
  // By default is true
  final bool autoSwiped;

  // This flag enable that the user can toggle the visibility with just tapping on
  // the header bar. By default is false
  final bool toggleVisibilityOnTap;

  // This property defines how 'smooth' or fast will be the animation. Low is
  // the slowest velocity and high is the fastest. By default is medium.
  final Smoothness smoothness;

  // This property is the elevation of the bottomSheet. Must be greater or equal
  // to 0. By default is 0.
  final double elevation;

  // This flag controls if the body is shown to the user by default. If it's
  // true, the body will be shown. If it's false the body will be hided. By
  // default it's false.
  final bool showOnAppear;
```

## Example

```dart
import 'package:flutter/material.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Solid bottom sheet example"),
      ),
      body: Center(
      child: FlutterLogo(),
      ),
      bottomSheet: SolidBottomSheet(
        headerBar: Container(
          color: Theme.of(context).primaryColor,
          height: 50,
          child: Center(
            child: Text("Swipe me!"),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: 30,
          child: Center(
            child: Text(
              "Hello! I'm a bottom sheet :D",
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
      ),
    );
  }
}

```

## Contribute
Feel free to fork and make pull request to enhance the package.

Github <a href="https://github.com/dbenitez-bcn/solid_bottom_sheet">here</a>.

## Posible incoming features
- **Controller** to be able to control the visibility internally from the app and don't depend of user's interaction.
- A **Shadow** that covers the back of the bottom sheet to feel more native.
- **Full view** option that displays the bottom sheet like a new navigated page. 
