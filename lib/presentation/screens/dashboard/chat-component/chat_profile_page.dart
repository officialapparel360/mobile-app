import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/core/app_style/app_text_style.dart';
import 'package:apparel_360/presentation/screens/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatProfilePage extends StatefulWidget {
  const ChatProfilePage({super.key, required this.userId});

  final String userId;

  @override
  State<ChatProfilePage> createState() => _ChatProfilePageState();
}

class _ChatProfilePageState extends State<ChatProfilePage> {
  late ProfileBloc bloc;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  fetchUserProfile() async {
    bloc = ProfileBloc();
    bloc.add(GetProfileDataEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text(
          'User Profile',
          style: AppTextStyle.getFont22Style(fontColor: AppColor.white),
        ),
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: SafeArea(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {

          },
          bloc: bloc,
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileDataSuccess) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40.0,
                      ),
                      _buildTextWidget('Name: ', state.profileData.name,
                          screenWidth: screenSize.width - 52),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: _buildTextWidget(
                            'UserType: ',
                            state.profileData.userType == 1
                                ? 'Admin'
                                : state.profileData.userType == 2
                                    ? 'Employee'
                                    : 'Customer',
                            screenWidth: screenSize.width - 52),
                      ),
                      _buildTextWidget(
                          'Shop Name: ', state.profileData.shopName,
                          screenWidth: screenSize.width - 52),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildTextWidget('City: ', state.profileData.city,
                                screenWidth: (screenSize.width) / 2 - 52),
                            Padding(
                              padding: const EdgeInsets.only(right: 25.0),
                              child: _buildTextWidget(
                                  'Pincode: ', state.profileData.pinCode,
                                  screenWidth: (screenSize.width) / 2 - 52),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('No Data found'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildTextWidget(String title, String value, {double? screenWidth}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
            width: screenWidth,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.black38),
            ),
            child: Text(value.isEmpty ? "N/A" : value))
      ],
    );
  }
}
