import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileStatBadgetWidget extends StatelessWidget {
  const ProfileStatBadgetWidget({
    super.key,
    required this.count,
    required this.label,
    required this.color,
  });

  final int count;
  final String label;
  final Color color;

  final _badgeDiameter = 50.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: _badgeDiameter,
          width: _badgeDiameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(
            child: Text(
              '$count',
              style: Theme.of(context).textTheme.displaySmall,
            ),
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
