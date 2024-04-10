import 'package:equatable/equatable.dart';
import 'package:restaurant_app_v1/data/model/restaurant.dart';

abstract class DetailRestaurantState extends Equatable {
  const DetailRestaurantState();
  @override
  List<Object> get props => [];
}

class DetailRestaurantLoading extends DetailRestaurantState {}

class DetailRestaurantError extends DetailRestaurantState {
  final String? message;
  const DetailRestaurantError({this.message});
}

class DetailRestaurantMessage extends DetailRestaurantState {
  final String message;
  const DetailRestaurantMessage({required this.message});
}

class DetailRestaurantSuccess extends DetailRestaurantState {
  final Restaurant dataRestaurant;
  const DetailRestaurantSuccess(this.dataRestaurant);
}

class DetailRestaurantEmpty extends DetailRestaurantState {}

class DetailRestaurantOffline extends DetailRestaurantState {}
