import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/domain/notifiers/should_display_tutorial_state_notifier.dart';

final shouldDisplayTutorialStateNotifierProvider =
    StateNotifierProvider<ShouldDisplayTutorialStateNotifier, bool>(
  (ref) => ShouldDisplayTutorialStateNotifier(),
);
