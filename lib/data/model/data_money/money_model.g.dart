// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoneyModel _$MoneyModelFromJson(Map<String, dynamic> json) => MoneyModel(
      availableCurrencies:
          Map<String, String>.from(json['available_currencies'] as Map),
    );

Map<String, dynamic> _$MoneyModelToJson(MoneyModel instance) =>
    <String, dynamic>{
      'available_currencies': instance.availableCurrencies,
    };
