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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 0),
                  onPressed: () => ref.read(learnProvider.notifier).previous(),
                  child: const Center(
                    child: Icon(Icons.arrow_back_rounded,
                        size: 60, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 0),
                  onPressed: () => ref.read(learnProvider.notifier).next(),
                  child: const Center(
                    child: Icon(Icons.arrow_forward_rounded,
                        size: 60, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
