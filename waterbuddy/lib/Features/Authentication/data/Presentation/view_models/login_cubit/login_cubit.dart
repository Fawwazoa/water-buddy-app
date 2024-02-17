import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterbuddy/Features/Authentication/data/Presentation/view_models/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login_user({required email, required password}) async {
    emit(LoginLoading());

    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFaliure(errMassage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(
            LoginFaliure(errMassage: 'Wrong password provided for that user.'));
      } else {
        emit(LoginFaliure(errMassage: 'Something went wrong'));
      }
    }
  }
}
