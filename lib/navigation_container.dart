import 'package:flutter/material.dart';
import 'package:quote_keeper/presentation/screens/dashboard_screen.dart';
import 'package:quote_keeper/presentation/screens/quotes_screen.dart';
import 'package:quote_keeper/presentation/screens/profile_screen.dart';
import 'package:quote_keeper/presentation/screens/settings_screen.dart';

/// This is the stateful widget that the main application instantiates.
class NavigationContainer extends StatefulWidget {
  const NavigationContainer({Key? key}) : super(key: key);

  @override
  State<NavigationContainer> createState() => _NavigationContainerState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _NavigationContainerState extends State<NavigationContainer> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    const QuotesScreen(),
    const ProfileScreen(),
    SettingsScreen(),
  ];

  // Update the selected index each time the user taps a button.
  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      // body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(fontSize: 20, color: Colors.blue),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.withOpacity(0.7),
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
