import 'package:apparel_360/core/network/repository.dart';
import 'package:apparel_360/core/services/service_locator.dart';
import 'package:apparel_360/data/model/profile_response_model.dart';
import 'package:apparel_360/data/prefernce/shared_preference.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final NetworkRepository _networkRepository = getIt<NetworkRepository>();

  ProfileBloc() : super(ProfileInitial()) {
    on<GetProfileDataEvent>((event, emit) async {
      var userId = await SharedPrefHelper.getUserId();
      Map<String, dynamic> userIdMap = {"userId": userId};
      final data = await _networkRepository.getProfileData(userIdMap);
      if (data["type"] == "success") {
        var profileData = ProfileResponse.fromJson(data);
        emit(ProfileDataSuccess(profileData: profileData.data));
      }
    });
  }
}
