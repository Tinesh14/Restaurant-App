// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantList _$RestaurantListFromJson(Map<String, dynamic> json) =>
    RestaurantList(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      count: json['count'] as int?,
      restaurants: (json['restaurants'] as List<dynamic>?)
          ?.map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantListToJson(RestaurantList instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'count': instance.count,
      'restaurants': instance.restaurants,
    };
