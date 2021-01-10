// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prescription _$PrescriptionFromJson(Map<String, dynamic> json) {
  return Prescription(
    id: json['id'] as int,
    name: json['name'] as String,
    creation_date: json['creation_date'] as String,
    notes: json['notes'] as String,
    price: json['price'] as int,
    pivot: json['pivot'] == null
        ? null
        : Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
    customers: json['customers'] == null ? 0 : json['customers'].length,
    presc_image: json['presc_image'] as String,
  );
}

Map<String, dynamic> _$PrescriptionToJson(Prescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'notes': instance.notes,
      'creation_date': instance.creation_date,
      'price': instance.price,
      'pivot': instance.pivot?.toJson(),
      'presc_image' : instance.presc_image,
      'customers': instance.customers,
    };
