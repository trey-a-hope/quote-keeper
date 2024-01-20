import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileStatBadgetWidget extends StatelessWidget {
  const ProfileStatBadgetWidget({
    Key? key,
    required this.count,
    required this.label,
    required this.color,
  }) : super(key: key);

  final int count;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
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
