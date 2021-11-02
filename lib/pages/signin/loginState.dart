abstract class LoginState {}

class InitLogState extends LoginState {}

class ChangepasswordState extends LoginState {}

class SocialLoginLoadingState extends LoginState {}

class SocialLoginSuccessState extends LoginState {
  late String uid;
  SocialLoginSuccessState(this.uid);
}

class SocialLoginFailState extends LoginState {}
