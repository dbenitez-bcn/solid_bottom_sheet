import 'package:flutter/material.dart';

import 'smoothness.dart';

class SolidBottomSheet extends StatefulWidget {
  // This is the current height of the bottomSheet's body
  double height;

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

  SolidBottomSheet({
    @required this.headerBar,
    @required this.body,
    this.minHeight = 0,
    this.maxHeight = 500,
    this.autoSwiped = true,
    this.toggleVisibilityOnTap = false,
    this.smoothness = Smoothness.medium,
    this.elevation = 0.0,
    this.showOnAppear = false,
  })  : assert(elevation >= 0.0),
        assert(minHeight >= 0.0) {
    this.height = this.showOnAppear ? this.maxHeight : this.minHeight;
  }

  @override
  _SolidBottomSheetState createState() => _SolidBottomSheetState();
}

class _SolidBottomSheetState extends State<SolidBottomSheet> {
  void _onVerticalDragUpdate(data) {
    if (((widget.height - data.delta.dy) > widget.minHeight) &&
        ((widget.height - data.delta.dy) < widget.maxHeight)) {
      setState(() {
        widget.height -= data.delta.dy;
      });
    }
  }

  void _onVerticalDragEnd(data) {
    if (data.primaryVelocity > 0)
      _hide();
    else
      _show();
  }

  void _onTap() {
    if (widget.height == widget.maxHeight)
      _hide();
    else
      _show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onVerticalDragUpdate: _onVerticalDragUpdate,
          onVerticalDragEnd: widget.autoSwiped ? _onVerticalDragEnd : null,
          onTap: widget.toggleVisibilityOnTap ? _onTap : null,
          child: Container(
            decoration: widget.elevation > 0
                ? BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: widget.elevation,
                    ),
                  ])
                : null,
            width: MediaQuery.of(context).size.width,
            child: widget.headerBar,
          ),
        ),
        AnimatedContainer(
          curve: Curves.easeOut,
          duration: Duration(milliseconds: widget.smoothness.value),
          height: widget.height,
          child: widget.body,
        ),
      ],
    );
  }

  void _hide() {
    setState(() {
      widget.height = widget.minHeight;
    });
  }

  void _show() {
    setState(() {
      widget.height = widget.maxHeight;
    });
  }
}
