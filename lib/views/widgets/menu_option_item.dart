import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MenuOptionItem extends StatelessWidget {
  final String title;
  final VoidCallback onEasyPressed;
  final VoidCallback onHardPressed;
  final VoidCallback onRandomPressed;
  final VoidCallback? onLearnPressed;

  const MenuOptionItem(
      {super.key,
      required this.title,
      required this.onEasyPressed,
      required this.onHardPressed,
      required this.onRandomPressed,
      this.onLearnPressed});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var isDesktop = !kIsWeb
        ? Platform.isWindows || Platform.isLinux || Platform.isMacOS
        : true;

    return Card(
      color: Theme.of(context).primaryColor,
      semanticContainer: false,
      margin: const EdgeInsets.all(8),
      child: SizedBox(
          width: isDesktop ? w / 2 : w - 48,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(12),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.subtitle1!.fontSize,
                        color: Colors.white60),
                  ),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  if (onLearnPressed != null)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 12, end: 12, bottom: 12),
                      child: OutlinedButton(
                        onPressed: onLearnPressed,
                        child: const Text('LEARN',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white70)),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 12, end: 12, bottom: 12),
                    child: OutlinedButton(
                      onPressed: onEasyPressed,
                      child: const Text('EASY',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white70)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 12, end: 12, bottom: 12),
                    child: OutlinedButton(
                      onPressed: onRandomPressed,
                      child: const Text('RANDOM',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white70)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 12, end: 12, bottom: 12),
                    child: OutlinedButton(
                      onPressed: onHardPressed,
                      child: const Text('HARD',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white70)),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
