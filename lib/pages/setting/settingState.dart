abstract class SettingState {}

class InitSettingState extends SettingState {}

class SocialGetUserLoadingState extends SettingState {}

class SocialGetUserSuccessState extends SettingState {}

class SocialLoginSuccessState extends SettingState {
  late String uid;
  SocialLoginSuccessState(this.uid);
}

class SocialGetUserFailState extends SettingState {}
