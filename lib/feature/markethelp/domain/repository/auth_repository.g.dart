// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthCredentials _$AuthCredentialsFromJson(Map<String, dynamic> json) =>
    AuthCredentials(
      login: json['login'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AuthCredentialsToJson(AuthCredentials instance) =>
    <String, dynamic>{'login': instance.login, 'password': instance.password};

AuthToken _$AuthTokenFromJson(Map<String, dynamic> json) =>
    AuthToken(token: json['token'] as String);

Map<String, dynamic> _$AuthTokenToJson(AuthToken instance) => <String, dynamic>{
  'token': instance.token,
};

AuthError _$AuthErrorFromJson(Map<String, dynamic> json) => AuthError(
  errorCode: json['errorCode'] as String,
  errorMessage: json['errorMessage'] as String,
);

Map<String, dynamic> _$AuthErrorToJson(AuthError instance) => <String, dynamic>{
  'errorCode': instance.errorCode,
  'errorMessage': instance.errorMessage,
};
