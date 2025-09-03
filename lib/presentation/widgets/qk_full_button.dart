import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class QKFullButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final String label;

  const QKFullButton({
    super.key,
    required this.onTap,
    required this.iconData,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).buttonTheme.colorScheme!.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: Colors.black,
              size: 20,
            ),
            const Gap(10),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
