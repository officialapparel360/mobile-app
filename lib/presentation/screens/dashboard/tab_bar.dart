import 'package:apparel_360/core/app_style/app_text_style.dart';
import 'package:apparel_360/presentation/screens/catelog/catelog.dart';
import 'package:apparel_360/presentation/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Apparels360',
              style: AppTextStyle.getFont22Style(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.notifications),
          //   onPressed: () {
          //     // Add your onPressed code here!
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => const ProfileScreen()));
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
              child: Text("Catalog"),
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
}
