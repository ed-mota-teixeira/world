import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MenuOptionItem extends StatelessWidget {
  final String title;
  final VoidCallback? onEasyPressed;
  final VoidCallback? onHardPressed;
  final VoidCallback? onRandomPressed;
  final VoidCallback? onLearnPressed;

  const MenuOptionItem(
      {super.key,
      required this.title,
      this.onEasyPressed,
      this.onHardPressed,
      this.onRandomPressed,
      this.onLearnPressed});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = !kIsWeb
        ? Platform.isWindows || Platform.isLinux || Platform.isMacOS
        : true;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: isDesktop ? w / 2 : w - 48,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12),
                  child: Icon(
                    Icons.circle_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 12,
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Theme.of(context).primaryColor,
          semanticContainer: false,
          margin: const EdgeInsets.all(8),
          child: SizedBox(
            width: isDesktop ? w / 2 : w - 48,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Wrap(
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
                  if (onEasyPressed != null)
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
                  if (onRandomPressed != null)
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
                  if (onHardPressed != null)
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
            ),
          ),
        )
      ],
    );
  }
}
