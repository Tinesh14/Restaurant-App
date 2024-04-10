import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app_v1/data/model/customer_review.dart';
import 'package:restaurant_app_v1/data/model/detail_restaurant.dart';
import 'package:restaurant_app_v1/data/model/list_restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String _imageUrl = 'https://restaurant-api.dicoding.dev/images/';
  String imageUrl(
    String pictureId, {
    String resolution = "small",
  }) =>
      "$_imageUrl$resolution/$pictureId";
  Future<RestaurantList> getListRestaurant() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/list"));
      if (response.statusCode == 200) {
        return restaurantListFromJson(response.body);
      } else {
        throw Exception('Failed to load get list restaurant');
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<RestaurantDetail> getDetailRestaurant(String id) async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
      if (response.statusCode == 200) {
        return restaurantDetailFromJson(response.body);
      } else {
        throw Exception('Failed to load get detail restaurant');
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<RestaurantList> searchRestaurant(String query) async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));
      if (response.statusCode == 200) {
        return restaurantListFromJson(response.body);
      } else {
        throw Exception('Failed to search list restaurant');
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<CustomerReviewResult> addReviewRestaurant(
      Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/review"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 201) {
        return CustomerReviewResult.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to add restaurant review ');
      }
    } catch (_) {
      rethrow;
    }
  }
}
