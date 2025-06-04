// auth_repository.dart
import 'package:dartz/dartz.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_repository.g.dart';

/// Credentials used for authentication
@JsonSerializable()
class AuthCredentials {
  final String login;
  final String password;

  factory AuthCredentials.fromJson(Map<String, dynamic> json) =>
      _$AuthCredentialsFromJson(json);

  AuthCredentials({required this.login, required this.password});
  Map<String, dynamic> toJson() => _$AuthCredentialsToJson(this);
}

/// Authentication token response
@JsonSerializable()
class AuthToken {
  final String token;

  factory AuthToken.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenFromJson(json);

  AuthToken({required this.token});
  Map<String, dynamic> toJson() => _$AuthTokenToJson(this);
}

/// Error response model
@JsonSerializable()
class AuthError {
  final String errorCode;
  final String errorMessage;

  factory AuthError.fromJson(Map<String, dynamic> json) =>
      _$AuthErrorFromJson(json);

  AuthError({required this.errorCode, required this.errorMessage});

  Map<String, dynamic> toJson() => _$AuthErrorToJson(this);
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
