part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileDataSuccess extends ProfileState {
  final ProfileData profileData;

  ProfileDataSuccess({required this.profileData});
}
