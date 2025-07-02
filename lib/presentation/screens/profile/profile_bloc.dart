import 'dart:io';

import 'package:apparel_360/core/network/repository.dart';
import 'package:apparel_360/core/services/service_locator.dart';
import 'package:apparel_360/core/utils/app_helper.dart';
import 'package:apparel_360/data/model/profile_response_model.dart';
import 'package:apparel_360/data/prefernce/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final NetworkRepository _networkRepository = getIt<NetworkRepository>();

  ProfileBloc() : super(ProfileInitial()) {
    on<GetProfileDataEvent>((event, emit) async {
      emit(ProfileLoading());
      Map<String, dynamic> userIdMap = {"userId": event.userId};
      final data = await _networkRepository.getProfileData(userIdMap);
      if (data["type"] == "success") {
        var profileData = ProfileResponse.fromJson(data);
        emit(ProfileDataSuccess(profileData: profileData.data));
      }
    });

    on<UpdateProfilePicEvent>((event, emit) async {
      var userId = await SharedPrefHelper.getUserId() ?? '';
      if (event.imageFile != null) {
        try {
          var response = await _networkRepository.updateProfilePic(
              userId, event.imageFile!, event.imageFile!.path);
          emit(ProfilePicUpdateSuccess(
              uploadedImage: response["data"]["profilePicPath"]));
        } catch (e) {
          emit(ProfilePicUpdateFail(errorMessage: e.toString()));
        }
      }
    });
  }
}
