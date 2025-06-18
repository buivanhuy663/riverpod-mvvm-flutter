import 'package:flutter/material.dart';

import '../../resources/resources.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({super.key});

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome_mosaic_outlined, size: 40),
          const SizedBox(height: 20),
          Text(
            'Looks like you have nothing to do!',
            style: AppTextStyles.s14w300,
          ),
        ],
      ),
    ),
  );
}
