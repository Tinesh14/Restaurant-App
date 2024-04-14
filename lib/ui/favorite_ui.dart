import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app_v1/cubit/favorite_cubit.dart';
import 'package:restaurant_app_v1/cubit/favorite_state.dart';
import 'package:restaurant_app_v1/data/db/database_helper.dart';
import 'package:restaurant_app_v1/widgets/empty.dart';
import 'package:restaurant_app_v1/widgets/error.dart';

import '../common/routes.dart';
import '../widgets/loading.dart';
import '../widgets/restaurant_row.dart';

class FavoriteUi extends StatefulWidget {
  const FavoriteUi({super.key});
  static Function refreshPage = () {};
  @override
  State<FavoriteUi> createState() => _FavoriteUiState();
}

class _FavoriteUiState extends State<FavoriteUi> {
  BuildContext? ctxFavorite;
  @override
  void initState() {
    super.initState();
    FavoriteUi.refreshPage = () {
      refresh();
    };
  }

  refresh() {
    if (mounted) {
      if (ctxFavorite != null) {
        BlocProvider.of<FavoriteCubit>(ctxFavorite!).init();
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    FavoriteUi.refreshPage = () {
      refresh();
    };
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 241, 241),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text(
                "Favorite Restaurant",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const Text(
                "Recommendation restaurant for you!",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocProvider<FavoriteCubit>(
                create: (context) => FavoriteCubit(
                  DatabaseHelper(),
                ),
                child: BlocConsumer<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    ctxFavorite = context;
                    if (state is FavoriteStateLoading) {
                      return const LoadingAnimation();
                    } else if (state is FavoriteStateEmpty) {
                      return const EmptyAnimation();
                    } else if (state is FavoriteStateError) {
                      return ErrorAnimation(
                        onPressed: () {
                          refresh();
                        },
                      );
                    } else if (state is FavoriteStateSuccess) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.dataRestaurant.length,
                        itemBuilder: (context, index) {
                          var item = state.dataRestaurant[index];
                          return InkWell(
                            onTap: () async {
                              await Navigator.pushNamed(
                                  context, PageRoutes.detailUi,
                                  arguments: {
                                    "id": item.id ?? "",
                                    "data": item,
                                  }).then(
                                (value) => refresh(),
                              );
                            },
                            child: RestaurantWidget(
                              image: item.pictureId ?? '',
                              title: item.name ?? '',
                              location: item.city ?? '',
                              rating: item.rating.toString(),
                              heroTag: "Favorite ${item.pictureId}",
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                  listener: (context, state) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
