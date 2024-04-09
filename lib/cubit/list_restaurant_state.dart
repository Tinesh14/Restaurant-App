import 'package:equatable/equatable.dart';
import 'package:restaurant_app_v1/data/model/restaurant.dart';

abstract class ListRestaurantState extends Equatable {
  const ListRestaurantState();
  @override
  List<Object> get props => [];
}

class ListRestaurantLoading extends ListRestaurantState {}

class ListRestaurantError extends ListRestaurantState {
  final String? message;
  const ListRestaurantError({this.message});
}

class ListRestaurantSuccess extends ListRestaurantState {
  final List<Restaurant> dataRestaurant;
  const ListRestaurantSuccess(this.dataRestaurant);
}

class ListRestaurantEmpty extends ListRestaurantState {}

class ListRestaurantOffline extends ListRestaurantState {}
