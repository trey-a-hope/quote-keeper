import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

class ProfileStatsWidget extends ConsumerWidget {
  const ProfileStatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Gap(40),
        Stack(
          children: [
            Container(
              height: 280,
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(60),
                    Center(
                        child: Text('YOUNESS MOUATASSIM',
                            style: TextStyle(
                                color: Colors.amber,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    Gap(10),
                    Text('younes@gmail.com',
                        style: TextStyle(color: Colors.black)),
                    Gap(25),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: profilesShortcutList.map<Widget>((e) {
                    //     return Container(
                    //       margin:
                    //           const EdgeInsets.symmetric(horizontal: 15),
                    //       padding: const EdgeInsets.all(13),
                    //       decoration: const BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: Colors.white,
                    //       ),
                    //       child: Icon(e['icon'], color: e['color']),
                    //     );
                    //   }).toList(),
                    // ),
                    Gap(25)
                  ],
                ),
              ),
            ),
            Positioned(
              left: 30,
              right: 30,
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE486DD),
                ),
                // child: Transform.scale(
                //   scale: 0.55,
                //   child: Image.asset(Assets.dash),
                // ),
              ),
            )
          ],
        ),
        const Gap(35),
      ],
    );
  }
}
