import 'package:chat_app/features/login/data/login_repository/login_remote_data_source/login_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
@injectable
class LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final InternetConnectionChecker internetConnectionChecker;

  LoginRepository({
    required this.remoteDataSource,
    required this.internetConnectionChecker,
  });

  Future<void> loginWithFirebase({required String email, required String password,}) async {
    if (await internetConnectionChecker.hasConnection) {
      await remoteDataSource.loginWithFirebase(email: email, password: password);
    }else {
      throw 'No Internet Connection';
    }
  }
}