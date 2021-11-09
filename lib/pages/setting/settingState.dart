abstract class SettingState {}

class InitSettingState extends SettingState {}

class SocialGetUserLoadingState extends SettingState {}

class SocialGetUserSuccessState extends SettingState {}

class SocialProfileImagePickedSuccessState extends SettingState {}

class SocialProfileImagePickedErrorState1 extends SettingState {}

class SocialProfileImagePickedErrorState2 extends SettingState {}

class SocialUserUpdateErrorState extends SettingState {}

class SocialLoginSuccessState extends SettingState {
  late String uid;
  SocialLoginSuccessState(this.uid);
}

class SocialGetUserFailState extends SettingState {}

class Changedataloading extends SettingState {}

class Updatedate extends SettingState {}

class Changedatasucess extends SettingState {}

class Changedatafail extends SettingState {}
