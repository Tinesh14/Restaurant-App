// To parse this JSON data, do
//
//     final restaurantList = restaurantListFromJson(jsonString);

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'restaurant.dart';

part 'list_restaurant.g.dart';


// pub run build_runner build --delete-conflicting-outputs
RestaurantList restaurantListFromJson(String str) =>
    RestaurantList.fromJson(json.decode(str));

String restaurantListToJson(RestaurantList data) => json.encode(data.toJson());

@JsonSerializable()
class RestaurantList {
  final bool? error;
  final String? message;
  final int? count;
  final List<Restaurant>? restaurants;

  RestaurantList({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  factory RestaurantList.fromJson(Map<String, dynamic> json) =>
      _$RestaurantListFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantListToJson(this);
}
