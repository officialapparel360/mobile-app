import 'dart:io';
import 'package:apparel_360/core/utils/app_helper.dart';
import 'package:apparel_360/core/utils/show_custom_toast.dart';
import 'package:apparel_360/data/model/profile_response_model.dart';
import 'package:apparel_360/data/prefernce/shared_preference.dart';
import 'package:apparel_360/presentation/screens/authentication/login_screen.dart';
import 'package:apparel_360/presentation/screens/profile/card_widget.dart';
import 'package:apparel_360/presentation/screens/profile/profile_bloc.dart';
import 'package:apparel_360/presentation/screens/profile/profile_pic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String uploadedImage = '';

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  fetchProfileData() async {
    bloc = ProfileBloc();
    var userId = await SharedPrefHelper.getUserId();
    bloc.add(GetProfileDataEvent(userId: userId!));
  }

  _logout(BuildContext context) async {
    final shouldLogout =
        await AppHelper().showLogoutConfirmationDialog(context);
    if (shouldLogout != true) return;

    await SharedPrefHelper.setLoginStatus(false);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Summary"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
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
          } else if (state is ProfilePicUpdateSuccess) {
            Navigator.pop(context);
            uploadedImage = state.uploadedImage;
          } else if (state is ProfilePicUpdateFail) {
            Navigator.pop(context);
            CustomToast.showToast(state.errorMessage);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ProfilePicWidget(
                        networkImage: uploadedImage.isNotEmpty
                            ? uploadedImage
                            : profileData.profilePicPath,
                        pickImage: () {
                          pickImage();
                        },
                        imageFile: _imageFile),
                    CardWidget(title: "Name", value: profileData.name ?? ''),
                    CardWidget(
                        title: "Shop Name", value: profileData.shopName ?? ''),
                    CardWidget(title: "GST No", value: profileData.gstNo ?? ''),
                    CardWidget(title: "City", value: profileData.city ?? ''),
                    CardWidget(
                        title: "Pincode", value: profileData.pinCode ?? ''),
                    CardWidget(
                        title: "Purchase Quantity",
                        value: profileData.purchaseQty ?? ''),
                    const SizedBox(
                      height: 40.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    AppHelper().showFullScreenLoader(context);
    if (pickedFile != null) {
      bloc.add(UpdateProfilePicEvent(imageFile: File(pickedFile.path)));
    }
  }
}
