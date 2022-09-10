import 'package:countries/controllers/region_provider.dart';
import 'package:countries/views/widgets/flag_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CorrectFlagWithName extends ConsumerWidget {
  const CorrectFlagWithName({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(regionProvider).correctCountry;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FlagImage(flagCountryCode: c.cca2!.toLowerCase()),
        Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(c.name!.common!,
                maxLines: 2, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
