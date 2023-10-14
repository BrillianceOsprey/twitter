import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter/Constants/Constants.dart';
import 'package:twitter/Screens/home_screen.dart';
import 'package:twitter/Screens/notifications_screen.dart';
import 'package:twitter/Screens/profile_screen.dart';
import 'package:twitter/Screens/search_screen.dart';

class FeedScreen extends StatefulWidget {
  final String currentUserId;

  const FeedScreen({Key? key, required this.currentUserId}) : super(key: key);
  @override
  FeedScreenState createState() => FeedScreenState();
}

class FeedScreenState extends State<FeedScreen> {
  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomeScreen(
          currentUserId: widget.currentUserId,
        ),
        SearchScreen(
          currentUserId: widget.currentUserId,
        ),
        NotificationsScreen(
          currentUserId: widget.currentUserId,
        ),
        ProfileScreen(
          currentUserId: widget.currentUserId,
          visitedUserId: widget.currentUserId,
        ),
      ].elementAt(_selectedTab),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        activeColor: kTweeterColor,
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
