abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterFaliure extends RegisterState {
  String errMassage;

  RegisterFaliure({required this.errMassage});
}
