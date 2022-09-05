import 'package:countries/models/menu_options.dart';
import 'package:flutter/material.dart';

class MenuDialog extends StatelessWidget {
  final List<MenuOptions> options;

  const MenuDialog({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: options
          .map((e) => SimpleDialogOption(
                onPressed: e.onSelected,
                child:
                    Text(e.text, maxLines: 2, overflow: TextOverflow.ellipsis),
              ))
          .toList(),
    );
  }
}
