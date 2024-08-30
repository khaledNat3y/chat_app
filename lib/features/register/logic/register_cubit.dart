import 'package:bloc/bloc.dart';
import 'package:chat_app/features/register/data/register_repository/register_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';
@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepository repo;
  RegisterCubit(this.repo) : super(RegisterInitial());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isObscureText = true;
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';

  Future<void> registerWithFirebase() async {
    emit(RegisterLoading());
    try {
      await repo.registerWithFirebase(email: email, password: password);
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError(message: e.toString()));
    }
  }
}
