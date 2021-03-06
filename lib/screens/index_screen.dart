import 'package:flutter/material.dart';

import 'profiles_screen.dart';
import 'search_screen.dart';
import 'suggested_movies_screen.dart';
import 'watch_list_screen.dart';

class IndexScreen extends StatefulWidget {
  static const String route = '/index';

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  static final List<Widget> _screens = [
    WatchListScreen(),
    SearchScreen(),
    SuggestedMoviesScreen(),
    ProfilesScreen(),
  ];
  int _currentScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentScreenIndex,
        onTap: (index) => setState(() => _currentScreenIndex = index),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            label: 'Watch List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Suggested',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profiles',
          ),
        ],
      ),
    );
  }
}
