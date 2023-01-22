import 'package:hamrokhata/Screens/auth/auth_local_data_source.dart';
import 'package:hamrokhata/Screens/auth/data_source/auth_repository.dart';

abstract class AuthRepository {
  Future<bool> isAuthenticated();

  Future<void> logout();
}

class AuthRepositoryImpl extends AuthRepository {
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({required this.authLocalDataSource});

  @override
  Future<bool> isAuthenticated() async {
    return authLocalDataSource.isAuthenticated();
  }

  @override
  Future<void> logout() async {
    return authLocalDataSource.clearToken();
  }
}
