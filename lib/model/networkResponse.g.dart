// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'networkResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkResponse<T> _$NetworkResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object json) fromJsonT,
) {
  return NetworkResponse<T>(
    msg: json['msg'] as String,
    error: json['error'] as bool,
    data: fromJsonT(json['data']),
  );
}

Map<String, dynamic> _$NetworkResponseToJson<T>(
  NetworkResponse<T> instance,
  Object Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': toJsonT(instance.data),
      'msg': instance.msg,
      'error': instance.error,
    };
