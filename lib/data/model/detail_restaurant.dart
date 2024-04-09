// To parse this JSON data, do
//
//     final restaurantDetail = restaurantDetailFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'restaurant.dart';

part 'detail_restaurant.g.dart';

RestaurantDetail restaurantDetailFromJson(String str) =>
    RestaurantDetail.fromJson(json.decode(str));

String restaurantDetailToJson(RestaurantDetail data) =>
    json.encode(data.toJson());

@JsonSerializable()
class RestaurantDetail {
  final bool? error;
  final String? message;
  final Restaurant? restaurant;

  RestaurantDetail({
    this.error,
    this.message,
    this.restaurant,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantDetailToJson(this);
}

@JsonSerializable()
class Category {
  final String? name;

  Category({
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Menus {
  final List<Category>? foods;
  final List<Category>? drinks;

  Menus({
    this.foods,
    this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => _$MenusFromJson(json);

  Map<String, dynamic> toJson() => _$MenusToJson(this);
}
