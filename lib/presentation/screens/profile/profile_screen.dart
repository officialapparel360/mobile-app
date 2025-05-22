import 'package:apparel_360/data/model/profile_response_model.dart';
import 'package:apparel_360/data/prefernce/shared_preference.dart';
import 'package:apparel_360/presentation/screens/authentication/login_screen.dart';
import 'package:apparel_360/presentation/screens/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc bloc;
  ProfileData profileData = ProfileData();

  @override
  void initState() {
    super.initState();
    bloc = ProfileBloc();
    bloc.add(GetProfileDataEvent());
  }

  Widget _buildDetailCard(String title, String value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value.isEmpty ? "N/A" : value),
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Text(tag, style: TextStyle(color: Colors.blueAccent)),
    );
  }

  _logout(BuildContext context) async {
    final shouldLogout = await _showLogoutConfirmationDialog(context);
    if (shouldLogout != true) return;

    await SharedPrefHelper.setLoginStatus(false);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  Future<bool?> _showLogoutConfirmationDialog(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    final roles = ['Retailer', 'Wholesaler', 'Trader'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Summary"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is ProfileDataSuccess) {
            profileData = state.profileData;
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                _buildDetailCard("Name", profileData.name ?? ''),
                _buildDetailCard("Shop Name", profileData.shopName ?? ''),
                _buildDetailCard("GST No", profileData.gstNo ?? ''),
                _buildDetailCard("City", profileData.city ?? ''),
                _buildDetailCard("Pincode", profileData.pinCode ?? ''),
                _buildDetailCard(
                    "Purchase Quantity", profileData.purchaseQty ?? ''),
              ],
            ),
          );
        },
      ),
    );
  }
}
