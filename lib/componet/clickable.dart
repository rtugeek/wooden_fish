import 'package:flutter/material.dart';

class Clickable extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget? child;

  const Clickable({Key? key, this.onTap, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(onTap: onTap, child: child),
    );
  }
}
