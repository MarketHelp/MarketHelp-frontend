// auth_repository.dart
import 'package:dartz/dartz.dart';

/// Credentials used for authentication
class AuthCredentials {
  final String login;
  final String password;

  AuthCredentials({required this.login, required this.password});
}

/// Authentication token response
class AuthToken {
  final String token;

  AuthToken({required this.token});
}

/// Error response model
class AuthError {
  final String errorCode;
  final String errorMessage;

  AuthError({required this.errorCode, required this.errorMessage});
}

/// Repository for authentication operations
abstract class AuthRepository {
  /// User authentication
  ///
  /// Returns [AuthToken] on success, or [AuthError] on failure
  Future<Either<AuthError, AuthToken>> login(AuthCredentials credentials);

  /// User registration
  ///
  /// Returns [AuthToken] on success, or [AuthError] on failure
  Future<Either<AuthError, AuthToken>> register(AuthCredentials credentials);
}
