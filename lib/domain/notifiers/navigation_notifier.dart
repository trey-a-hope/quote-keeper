import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Navigation {
  home(0),
  quotes(1),
  profile(2),
  settings(3),
  ;

  const Navigation(this.curIndex);

  final int curIndex;
}

class NavigationNotifier extends AutoDisposeNotifier<Navigation> {
  @override
  Navigation build() => Navigation.home;

  void updateNav(Navigation nav) => state = nav;
}
