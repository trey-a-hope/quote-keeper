import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileStatBadgetWidget extends StatelessWidget {
  const ProfileStatBadgetWidget({
    Key? key,
    required this.count,
    required this.label,
  }) : super(key: key);

  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).canvasColor,
          ),
          child: Text(
            '$count',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        const Gap(5),
        Text(
          label,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
