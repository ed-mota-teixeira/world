import 'package:countries/models/menu_options.dart';
import 'package:countries/utils/routing/route_names.dart';
import 'package:countries/views/dialogs/dialogs.dart';
import 'package:countries/views/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  void showFlagsOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (c) {
          return MenuDialog(
            options: [
              MenuOptions(
                  text: 'EASY',
                  onSelected: () {
                    Navigator.of(c).pop();
                    Navigator.of(context)
                        .pushNamed(kFlagsGameRoute, arguments: true);
                  }),
              MenuOptions(
                  text: 'ALL',
                  onSelected: () {
                    Navigator.of(c).pop();
                    Navigator.of(context).pushNamed(kFlagsGameRoute);
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('WORLD QUIZ'), centerTitle: true,),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // const Text('OPTIONS'),
              GameMainMenuItem(
                onPressed: () => showFlagsOptions(context),
                text: 'FLAGS',
              ),
              GameMainMenuItem(
                onPressed: () =>
                    Navigator.of(context).pushNamed(kCapitalsGameRoute),
                text: 'CAPITALS',
              ),
              GameMainMenuItem(
                onPressed: () =>
                    Navigator.of(context).pushNamed(kCapitalsGameRoute),
                text: 'REGIONS',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
