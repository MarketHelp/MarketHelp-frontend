import 'package:dartz/dartz.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<AuthError, AuthToken>> login(AuthCredentials credentials) {
    if (credentials.login.isEmpty || credentials.password.isEmpty) {
      return Future.value(
        Left(AuthError(errorCode: '400', errorMessage: 'Invalid credentials')),
      );
    }
    if (credentials.login == "admin" && credentials.password == "admin") {
      return Future.value(Right(AuthToken(token: "token")));
      // Simulate a successful login
    } else {
      return Future.value(
        Left(AuthError(errorCode: '401', errorMessage: 'Unauthorized')),
      );
    }
  }

  @override
  Future<Either<AuthError, AuthToken>> register(AuthCredentials credentials) {
    if (credentials.login.isEmpty || credentials.password.isEmpty) {
      return Future.value(
        Left(AuthError(errorCode: '400', errorMessage: 'Invalid credentials')),
      );
    }
    if (credentials.login == "admin" && credentials.password == "admin") {
      return Future.value(Right(AuthToken(token: "token")));
      // Simulate a successful registration
    } else {
      return Future.value(
        Left(AuthError(errorCode: '401', errorMessage: 'Unauthorized')),
      );
    }
  }
}
