part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetProfileDataEvent extends ProfileEvent {
  final String userId;

  GetProfileDataEvent({required this.userId});
}

class UpdateProfilePicEvent extends ProfileEvent {
  final File? imageFile;

  UpdateProfilePicEvent({required this.imageFile});
}
