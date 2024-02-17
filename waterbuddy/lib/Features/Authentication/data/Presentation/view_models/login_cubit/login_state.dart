abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFaliure extends LoginState {
  String errMassage;

  LoginFaliure({required this.errMassage});
}
