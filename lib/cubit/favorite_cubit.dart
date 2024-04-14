import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/db/database_helper.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final DatabaseHelper databaseHelper;
  FavoriteCubit(this.databaseHelper) : super(FavoriteStateLoading()) {
    init();
  }

  init() async {
    try {
      emit(FavoriteStateLoading());
      var data = await databaseHelper.getFavorites();
      if (data != null && data.isNotEmpty) {
        emit(FavoriteStateSuccess(data));
      } else {
        emit(FavoriteStateEmpty());
      }
    } catch (e) {
      emit(const FavoriteStateError(message: 'Something Went Wrong !!!'));
    }
  }
}
