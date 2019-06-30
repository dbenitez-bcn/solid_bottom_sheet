import 'package:flutter/material.dart';

import 'solidBottomSheet.dart';

class BodyWithBottomSheet extends StatelessWidget {
  final Widget body;
  final SolidBottomSheet bottomSheet;

  BodyWithBottomSheet({this.body, this.bottomSheet});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        body,
        bottomSheet
      ],
    );
  }
}
