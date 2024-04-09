import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app_v1/cubit/detail_restaurant_state.dart';
import 'package:restaurant_app_v1/data/api/api_service.dart';
import 'package:restaurant_app_v1/data/model/restaurant.dart';

class DetailRestaurantCubit extends Cubit<DetailRestaurantState> {
  final ApiService apiService;
  final String id;
  DetailRestaurantCubit(this.apiService, this.id)
      : super(DetailRestaurantLoading()) {
    init();
  }

  init({bool isLoad = false}) async {
    try {
      if (isLoad) emit(DetailRestaurantLoading());
      var response = await apiService.getDetailRestaurant(id);
      emit(DetailRestaurantSuccess(response.restaurant ?? Restaurant()));
    } catch (e) {
      if (e is SocketException) {
        emit(DetailRestaurantOffline());
      } else {
        emit(const DetailRestaurantError(message: 'Something Went Wrong !!!'));
      }
    }
  }
}
