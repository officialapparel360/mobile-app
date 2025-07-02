part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

class ProfileDataSuccess extends ProfileState {
  final ProfileData profileData;

  ProfileDataSuccess({required this.profileData});
}

class ProfilePicUpdateSuccess extends ProfileState {
  final String uploadedImage;

  ProfilePicUpdateSuccess({required this.uploadedImage});
}

class ProfilePicUpdateFail extends ProfileState {
  final String errorMessage;

  ProfilePicUpdateFail({required this.errorMessage});
}
