// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      password: json['password'] as String?,
      signupId: json['signupId'] as String?,
      signupPassword: json['signupPassword'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'password': instance.password,
      'signupId': instance.signupId,
      'signupPassword': instance.signupPassword,
      'confirmPassword': instance.confirmPassword,
    };
