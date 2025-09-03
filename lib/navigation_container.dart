import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/domain/notifiers/navigation_notifier.dart';
import 'package:quote_keeper/presentation/screens/dashboard_screen.dart';
import 'package:quote_keeper/presentation/screens/quotes_screen.dart';
import 'package:quote_keeper/presentation/screens/profile_screen.dart';
import 'package:quote_keeper/presentation/screens/settings_screen.dart';
import 'package:quote_keeper/utils/config/providers.dart';

/// This is the stateful widget that the main application instantiates.
class NavigationContainer extends ConsumerStatefulWidget {
  const NavigationContainer({super.key});

  @override
  ConsumerState<NavigationContainer> createState() =>
      _NavigationContainerState();
}

class _NavigationContainerState extends ConsumerState<NavigationContainer> {
  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardScreen(),
    const QuotesScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final nav = ref.watch(Providers.navigationProvider);

    return Scaffold(
      body: IndexedStack(
        index: nav.curIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(
          fontSize: 20,
          color: Colors.blue,
        ),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.withValues(alpha: 0.7),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Quotes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: nav.curIndex,
        onTap: (val) =>
            ref.read(Providers.navigationProvider.notifier).updateNav(
                  Navigation.values.firstWhere((e) => e.curIndex == val),
                ),
      ),
    );
  }
}
