// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantDetail _$RestaurantDetailFromJson(Map<String, dynamic> json) =>
    RestaurantDetail(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      restaurant: json['restaurant'] == null
          ? null
          : Restaurant.fromJson(json['restaurant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RestaurantDetailToJson(RestaurantDetail instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'restaurant': instance.restaurant,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'name': instance.name,
    };

Menus _$MenusFromJson(Map<String, dynamic> json) => Menus(
      foods: (json['foods'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      drinks: (json['drinks'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenusToJson(Menus instance) => <String, dynamic>{
      'foods': instance.foods,
      'drinks': instance.drinks,
    };
