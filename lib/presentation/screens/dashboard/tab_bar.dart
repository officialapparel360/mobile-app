import 'package:apparel_360/presentation/screens/catelog/catelog.dart';
import 'package:flutter/material.dart';

import '../../../data/prefernce/shared_preference.dart';
import '../authentication/login_screen.dart';
import '../catelog/clearance.dart';
import 'home-component/home_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text('Appreal360'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Add your onPressed code here!
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              // Handle menu item selection
              _handleMenuSelection(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Logout',
                  child: Text('Logout'),
                ),
                // const PopupMenuItem<String>(
                //   value: 'About Us',
                //   child: Text('About Us'),
                // ),
              ];
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              child: Text("Chat"),
            ),
            Tab(
              child: Text("Catalogue"),
            ),
            Tab(
              child: Text("Clearance"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(child: HomeScreen()),
          Center(child: Catelog()),
          Center(child: ClearanceCategory()),
        ],
      ),
    );
  }

  void _handleMenuSelection(String value) async {
    if (value == 'Logout') {
      final shouldLogout = await _showLogoutConfirmationDialog();
      if (shouldLogout != true) return;

      await SharedPrefHelper.setLoginStatus(false);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else if (value == 'About Us') {
      // about us functionality
    }
  }

  Future<bool?> _showLogoutConfirmationDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
