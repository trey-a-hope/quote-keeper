import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/presentation/widgets/app_bar_widget.dart';
import 'package:quote_keeper/utils/constants/globals.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBarWidget.appBar(
        title: 'About',
        implyLeading: true,
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Version'),
              Text(
                '${Globals.version} + (${Globals.buildNumber})',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
