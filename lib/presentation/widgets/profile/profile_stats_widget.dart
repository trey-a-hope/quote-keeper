import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:quote_keeper/utils/config/providers.dart';

class ProfileStatsWidget extends ConsumerWidget {
  const ProfileStatsWidget({super.key});

  final _containerHeight = 200.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(Providers.userAsyncNotifierProvider);

    return user.when(
      data: (data) => Column(
        children: [
          Stack(
            children: [
              Container(
                height: _containerHeight,
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: _containerHeight - 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(60),
                      Center(
                        child: Text(
                          data!.username,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        data.email,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
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
                    color: Colors.deepOrangeAccent,
                  ),
                  child: Center(
                    child: Text(
                      data.username[0].toUpperCase(),
                      style: const TextStyle(fontSize: 50, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
          const Gap(35),
        ],
      ),
      error: (err, stack) => Center(child: Text(err.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
