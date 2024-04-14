import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'customer_review.dart';
import 'detail_restaurant.dart';

part 'restaurant.g.dart';

@JsonSerializable(explicitToJson: true)
class Restaurant {
  final String? id;
  final String? name;
  final String? description;
  final String? city;
  final String? address;
  final String? pictureId;
  final List<Category>? categories;
  final Menus? menus;
  final dynamic rating;
  final List<CustomerReview>? customerReviews;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json, {bool decodeString = false}) =>
      _$RestaurantFromJson(json, decodeString);

  Map<String, dynamic> toJson({bool convertToString = false}) =>
      _$RestaurantToJson(this, convertToString);
}
