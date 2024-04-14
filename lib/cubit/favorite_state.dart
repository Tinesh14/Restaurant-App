import 'package:equatable/equatable.dart';
import 'package:restaurant_app_v1/data/model/restaurant.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
  @override
  List<Object> get props => [];
}

class FavoriteStateLoading extends FavoriteState {}

class FavoriteStateSuccess extends FavoriteState {
  final List<Restaurant> dataRestaurant;
  const FavoriteStateSuccess(this.dataRestaurant);
}

class FavoriteStateEmpty extends FavoriteState {}

class FavoriteStateError extends FavoriteState {
  final String? message;
  const FavoriteStateError({this.message});
}
