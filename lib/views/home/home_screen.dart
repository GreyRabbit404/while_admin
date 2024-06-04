import 'package:flutter/material.dart';
import 'package:while_admin/drawer/custom_drawer.dart';
import 'package:while_admin/views/Requests/view_requests.dart';
import 'package:while_admin/views/home/communities/community_screen.dart';
import 'package:while_admin/views/home/loops/loop_screen.dart';
import 'package:while_admin/views/home/users/user_screen.dart';
import 'package:while_admin/views/home/videos/video_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  // Add the RequestsScreen to the list of screens
  final List<Widget> _screens = [
    const VideosScreen(),
    const LoopsView(),
    const UsersListScreen(),
    const CommunitiesListScreen(),
    const RequestsScreen(), // New screen added here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 35.0,
        titleSpacing: 15,
        title: const Text('While'),
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu));
          },
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.loop),
            label: 'Loops',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Communities',
          ),
          BottomNavigationBarItem(
            // New navigation item for Requests
            icon: Icon(Icons.request_page),
            label: 'Requests',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      drawer: const CustomDrawer(),
    );
  }
}
