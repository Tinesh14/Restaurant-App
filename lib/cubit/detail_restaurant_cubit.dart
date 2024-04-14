import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app_v1/cubit/detail_restaurant_state.dart';
import 'package:restaurant_app_v1/data/api/api_service.dart';
import 'package:restaurant_app_v1/data/db/database_helper.dart';
import 'package:restaurant_app_v1/data/model/restaurant.dart';

class DetailRestaurantCubit extends Cubit<DetailRestaurantState> {
  final ApiService apiService;
  final String id;
  final DatabaseHelper databaseHelper;
  DetailRestaurantCubit(this.apiService, this.id,
      {required this.databaseHelper})
      : super(DetailRestaurantLoading()) {
    init();
  }

  addToFavorite(Restaurant dataRestaurant) async {
    if (await isFavorite) {
      // delete favorite
      databaseHelper.removeFavorite(id);
    } else {
      // add favorite
      databaseHelper.insertFavorite(dataRestaurant);
    }
  }

  Future<bool> get isFavorite async =>
      (await databaseHelper.getFavoriteById(id)).isNotEmpty;

  init({bool isLoad = false}) async {
    try {
      if (isLoad) emit(DetailRestaurantLoading());
      var response = await apiService.getDetailRestaurant(id);
      emit(DetailRestaurantSuccess(
        response.restaurant ?? Restaurant(),
        isFavorite: await isFavorite,
      ));
    } catch (e) {
      if (e is SocketException) {
        emit(DetailRestaurantOffline());
      } else {
        emit(const DetailRestaurantError(message: 'Something Went Wrong !!!'));
      }
    }
  }

  addReview(Map<String, dynamic> data) async {
    try {
      emit(DetailRestaurantLoading());
      var response = await apiService.addReviewRestaurant(data);
      emit(DetailRestaurantMessage(message: response.message ?? ''));
      init(isLoad: true);
    } catch (e) {
      emit(const DetailRestaurantMessage(message: 'Something Went Wrong !!!'));
      init(isLoad: true);
    }
  }
}
