import 'package:flutter/material.dart';

import '../solid_bottom_sheet.dart';
import 'smoothness.dart';

class SolidBottomSheet extends StatefulWidget {
  // This controls the minimum height of the body. Must be greater or equal of
  // 0. By default is 0
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

  // This flag enable that the user can toggle the visibility with just tapping
  // on the header bar. By default is false
  final bool toggleVisibilityOnTap;

  // This flag enable that users can swipe the body and hide or show the
  // solid bottom sheet. Turn on false if you don't want to let the user
  // interact with the solid bottom sheet. By default is false.
  final bool draggableBody;

  // This flag enable that users can swipe the header and hide or show the
  // solid bottom sheet. Turn on false if you don't want to let the user
  // interact with the solid bottom sheet. By default is true.
  final bool canUserSwipe; // TODO: Change to draggableHeader

  // This property defines how 'smooth' or fast will be the animation. Low is
  // the slowest velocity and high is the fastest. By default is medium.
  final Smoothness smoothness;

  // This property is the elevation of the bottomSheet. Must be greater or equal
  // to 0. By default is 0.
  final double elevation;

  // This flag controls if the body is shown to the user by default. If it's
  // true, the body will be shown. If it's false the body will be hided. By
  // default it's false.
  final bool showOnAppear; // TODO: change to openedByDefault

  // This object used to control behavior internally
  // from the app and don't depend of user's interaction.
  // can hide and show  methods plus have isOpened variable
  // to check widget visibility on a screen
  SolidController controller;

  // This method will be executed when the solid bottom sheet is completely
  // opened.
  final Function onShow;

  // This method will be executed when the solid bottom sheet is completely
  // closed.
  final Function onHide;

  SolidBottomSheet({
    Key key,
    @required this.headerBar,
    @required this.body,
    this.controller,
    this.minHeight = 0,
    this.maxHeight = 500,
    this.autoSwiped = true,
    this.toggleVisibilityOnTap = false,
    this.canUserSwipe = true,
    this.draggableBody = false,
    this.smoothness = Smoothness.medium,
    this.elevation = 0.0,
    this.showOnAppear = false,
    this.onShow,
    this.onHide,
  })  : assert(elevation >= 0.0),
        assert(minHeight >= 0.0),
        super(key: key) {
    if (controller == null) {
      this.controller = SolidController();
    }
    this.controller.height =
        this.showOnAppear ? this.maxHeight : this.minHeight;
    this.controller.smoothness = smoothness;
  }

  @override
  _SolidBottomSheetState createState() => _SolidBottomSheetState();
}

class _SolidBottomSheetState extends State<SolidBottomSheet> {
  bool isDragDirectionUp;

  void _onVerticalDragUpdate(data) {
    _setNativeSmoothness();
    if (((widget.controller.height - data.delta.dy) > widget.minHeight) &&
        ((widget.controller.height - data.delta.dy) < widget.maxHeight)) {
      isDragDirectionUp = data.delta.dy <= 0;
      widget.controller.height -= data.delta.dy;
    }
  }

  void _onVerticalDragEnd(data) {
    _setUsersSmoothness();

    if (isDragDirectionUp && widget.controller.value)
      _show();
    else if (!isDragDirectionUp && !widget.controller.value)
      _hide();
    else
      widget.controller.value = isDragDirectionUp;
  }

  void _onTap() {
    final bool isOpened = widget.controller.height == widget.maxHeight;
    widget.controller.value = !isOpened;
  }

  Function _controllerListener;

  @override
  void initState() {
    super.initState();
    widget.controller.value = widget.showOnAppear;
    _controllerListener = () {
      widget.controller.value ? _show() : _hide();
    };
    widget.controller.addListener(_controllerListener);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onVerticalDragUpdate:
              widget.canUserSwipe ? _onVerticalDragUpdate : null,
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
        StreamBuilder<double>(
          stream: widget.controller.heightStream,
          initialData: widget.controller.height,
          builder: (_, snapshot) {
            return AnimatedContainer(
              curve: Curves.easeOut,
              duration:
                  Duration(milliseconds: widget.controller.smoothness.value),
              height: snapshot.data,
              child: GestureDetector(
                onVerticalDragUpdate:
                    widget.draggableBody ? _onVerticalDragUpdate : null,
                onVerticalDragEnd:
                    widget.autoSwiped ? _onVerticalDragEnd : null,
                onTap: widget.toggleVisibilityOnTap ? _onTap : null,
                child: widget.body,
              ),
            );
          },
        ),
      ],
    );
  }

  void _hide() {
    if (widget.onHide != null) widget.onHide();
    widget.controller.height = widget.minHeight;
  }

  void _show() {
    if (widget.onShow != null) widget.onShow();
    widget.controller.height = widget.maxHeight;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_controllerListener);
    super.dispose();
  }

  void _setUsersSmoothness() {
    widget.controller.smoothness = widget.smoothness;
  }

  void _setNativeSmoothness() {
    widget.controller.smoothness = Smoothness.withValue(5);
  }
}
