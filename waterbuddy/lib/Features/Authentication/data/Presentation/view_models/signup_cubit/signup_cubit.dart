import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterbuddy/Features/Authentication/data/Presentation/view_models/signup_cubit/signup_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register_user({required email, required password}) async {
    emit(RegisterLoading());

    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFaliure(errMassage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFaliure(
            errMassage: 'The account already exists for that email.'));
      } else {
        emit(RegisterFaliure(errMassage: 'Something went wrong'));
      }
    }
  }
}
