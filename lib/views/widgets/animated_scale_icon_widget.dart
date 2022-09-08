import 'package:flutter/material.dart';

class AnimatedScaleIconWidget extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const AnimatedScaleIconWidget(
      {super.key, required this.icon, required this.onPressed});

  @override
  createState() => _AnimatedScaleIconWidget();
}

class _AnimatedScaleIconWidget extends State<AnimatedScaleIconWidget> {
  int _currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: widget.key,
      iconSize: 80,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        transitionBuilder: (child, anim) =>
            ScaleTransition(scale: anim, child: child),
        child: _currIndex == 0
            ? Icon(widget.icon, )
            : Icon(widget.icon, key: UniqueKey()),
      ),
      onPressed: () {
        widget.onPressed();
        setState(() => _currIndex = _currIndex == 0 ? 1 : 0);
      },
    );
  }
}
