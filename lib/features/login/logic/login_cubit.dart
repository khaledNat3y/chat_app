import 'package:bloc/bloc.dart';
import 'package:chat_app/features/login/data/login_repository/login_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginRepository repository;
  LoginCubit(this.repository) : super(LoginInitial());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool isObscureText = true;

  Future<void> loginWithFirebase() async {
    emit(LoginLoading());
    try {
      await repository.loginWithFirebase(email: email, password: password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(message: "Login failed. Please check your credentials and try again."));
    }
  }
}
