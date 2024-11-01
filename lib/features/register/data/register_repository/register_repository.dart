
import 'package:chat_app/features/register/data/register_repository/register_remote_data_source/register_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
@injectable
class RegisterRepository {
  final RegisterRemoteDataSource register;
  final InternetConnectionChecker internetConnectionChecker;

  RegisterRepository({
    required this.register,
    required this.internetConnectionChecker,
  });
  Future<void> registerWithFirebase({required String email, required String password,}) async {
    if (await internetConnectionChecker.hasConnection) {
      await register.registerWithFirebase(email, password);
    }else {
      throw 'No Internet Connection';
    }
  }
}