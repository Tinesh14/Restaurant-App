import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app_v1/cubit/list_restaurant_state.dart';
import 'package:restaurant_app_v1/data/api/api_service.dart';

class ListRestaurantCubit extends Cubit<ListRestaurantState> {
  final ApiService apiService;
  ListRestaurantCubit(this.apiService) : super(ListRestaurantLoading()) {
    init();
  }

  init({bool isLoad = false}) async {
    try {
      if (isLoad) emit(ListRestaurantLoading());
      var response = await apiService.getListRestaurant();
      if (response.restaurants?.isNotEmpty ?? false) {
        emit(ListRestaurantSuccess(response.restaurants ?? []));
      } else {
        emit(ListRestaurantEmpty());
      }
    } catch (e) {
      if (e is SocketException) {
        emit(ListRestaurantOffline());
      } else {
        emit(const ListRestaurantError(message: 'Something Went Wrong !!!'));
      }
    }
  }

  search(String query) async {
    try {
      emit(ListRestaurantLoading());
      var response = await apiService.searchRestaurant(query);
      if (response.restaurants?.isNotEmpty ?? false) {
        emit(ListRestaurantSuccess(response.restaurants ?? []));
      } else {
        emit(ListRestaurantEmpty());
      }
    } catch (e) {
      if (e is SocketException) {
        emit(ListRestaurantOffline());
      } else {
        emit(const ListRestaurantError(message: 'Something Went Wrong !!!'));
      }
    }
  }
}
