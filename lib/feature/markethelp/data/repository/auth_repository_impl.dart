import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:markethelp_frontend/core/constants/constants.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Dio _dio = GetIt.I<Dio>();
  @override
  Future<Either<AuthError, AuthToken>> login(
    AuthCredentials credentials,
  ) async {
    try {
      print(credentials.toJson());
      final response = await _dio.post(
        'http://minecraftslaves.duckdns.org:8082/auth/login',
        data: credentials.toJson(),
        options: Options(headers: MarketHelpConstants.headers),
      );
      print(response.data);
      return Right(AuthToken(token: response.data['token']));
    } catch (e) {
      return Left(AuthError(errorCode: '500', errorMessage: 'Login failed'));
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
