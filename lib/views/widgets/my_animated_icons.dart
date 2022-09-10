import 'package:flutter/material.dart';

class MyAnimatedIcons extends StatefulWidget {
  final IconData iconData1;
  final IconData iconData2;
  final VoidCallback onPressed;

  const MyAnimatedIcons(
      {super.key,
      required this.iconData1,
      required this.iconData2,
      required this.onPressed});

  @override
  createState() => _MyAnimatedIcon();
}

class _MyAnimatedIcon extends State<MyAnimatedIcons> {
  int _currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          transitionBuilder: (child, anim) => RotationTransition(
                turns: child.key == const ValueKey('icon1')
                    ? Tween<double>(begin: 0, end: 1).animate(anim)
                    : Tween<double>(begin: 1, end: 0).animate(anim),
                child: ScaleTransition(scale: anim, child: child),
              ),
          child: _currIndex == 0
              ? Icon(widget.iconData1, key: const ValueKey('icon1'))
              : Icon(widget.iconData2, key: const ValueKey('icon2'))),
      onPressed: () {
        setState(() => _currIndex = _currIndex == 0 ? 1 : 0);
        widget.onPressed();
      },
    );
  }
}
