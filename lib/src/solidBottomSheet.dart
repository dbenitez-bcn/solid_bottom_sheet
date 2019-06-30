import 'package:flutter/material.dart';

import 'smoothness.dart';

class SolidBottomSheet extends StatefulWidget {
  double height;
  final double minHeight;
  final double maxHeight;
  final Widget body;
  final Widget headerBar;
  final bool autoSwiped;
  final bool toggleVisibilityOnTap;
  final Smoothness smoothness;
  final double elevation;

  SolidBottomSheet({
    @required this.headerBar,
    @required this.body,
    this.minHeight = 0,
    this.maxHeight = 500,
    this.autoSwiped = true,
    this.toggleVisibilityOnTap = false,
    this.smoothness = Smoothness.medium,
    this.elevation = 0.0,
  }) {
    this.height = this.minHeight;
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
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: widget.elevation,
              ),
            ]),
            width: MediaQuery.of(context).size.width,
            child: widget.headerBar,
          ),
        ),
        AnimatedContainer(
            curve: Curves.easeOut,
            duration: Duration(milliseconds: widget.smoothness.value),
            height: widget.height,
            child: widget.body),
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
