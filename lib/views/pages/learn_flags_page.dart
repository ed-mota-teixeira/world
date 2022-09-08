import 'package:countries/controllers/learn_flags_control.dart';
import 'package:countries/views/widgets/flag_image_widget.dart';
import 'package:countries/views/widgets/name_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LearnFlagsPage extends ConsumerWidget {
  const LearnFlagsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(learnProvider);

    return SafeArea(
        child: Scaffold(
      appBar:
          AppBar(automaticallyImplyLeading: true, title: const Text('LEARN')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlagImage(flagCountryCode: controller.cca2!.toLowerCase()),
            NameWidget(text: controller.name!.common!.toUpperCase()),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  color: Theme.of(context).primaryColor,
                  iconSize: 80,
                  onPressed: () => ref.read(learnProvider.notifier).previous(),
                  icon: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: const Icon(Icons.arrow_circle_left),
                  ),
                ),
                IconButton(
                  iconSize: 80,
                  color: Theme.of(context).primaryColor,
                  onPressed: () => ref.read(learnProvider.notifier).next(),
                  icon: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: const Icon(Icons.arrow_circle_right)),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
