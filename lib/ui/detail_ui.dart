// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_app_v1/cubit/detail_restaurant_cubit.dart';
import 'package:restaurant_app_v1/cubit/detail_restaurant_state.dart';
import 'package:restaurant_app_v1/data/api/api_service.dart';
import 'package:restaurant_app_v1/data/model/detail_restaurant.dart';
import 'package:restaurant_app_v1/widgets/error.dart';
import 'package:restaurant_app_v1/widgets/loading.dart';
import 'package:restaurant_app_v1/widgets/offline.dart';

import '../widgets/appbar.dart';

class DetailUi extends StatefulWidget {
  String id;
  DetailUi({
    super.key,
    required this.id,
  });

  @override
  State<DetailUi> createState() => _DetailUiState();
}

class _DetailUiState extends State<DetailUi> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailRestaurantCubit>(
      create: (context) => DetailRestaurantCubit(
        ApiService(),
        widget.id,
      ),
      child: BlocConsumer<DetailRestaurantCubit, DetailRestaurantState>(
        builder: (context, state) {
          if (state is DetailRestaurantLoading) {
            return wrapScaffold(
              const LoadingAnimation(),
            );
          }
          // else if (state is DetailRestaurantEmpty) {
          //   return wrapScaffold(
          //     const EmptyAnimation(),
          //   );
          // }
          else if (state is DetailRestaurantError) {
            return wrapScaffold(
              ErrorAnimation(
                onPressed: () {
                  BlocProvider.of<DetailRestaurantCubit>(context)
                      .init(isLoad: true);
                },
                message: state.message,
              ),
            );
          } else if (state is DetailRestaurantOffline) {
            return wrapScaffold(
              OfflineAnimation(
                onPressed: () {
                  BlocProvider.of<DetailRestaurantCubit>(context)
                      .init(isLoad: true);
                },
              ),
            );
          } else if (state is DetailRestaurantSuccess) {
            var data = state.dataRestaurant;
            return CustomAppBar(
              tag: data.pictureId ?? 'image',
              titleAppBar: data.name ?? '',
              urlImage: ApiService().imageUrl(
                data.pictureId ?? '',
                resolution: "medium",
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Restaurant ${data.name ?? ''}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              data.city ?? '-',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ReadMoreText(
                        data.description ?? '-',
                        trimMode: TrimMode.Line,
                        trimLines: 4,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Foods",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      widgetMenu(
                          data.menus?.foods, 'assets/food_animation.json'),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Drinks",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      widgetMenu(
                          data.menus?.drinks, 'assets/drink_animation.json'),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
        listener: (context, state) {},
      ),
    );
  }

  wrapScaffold(Widget child) {
    return Scaffold(
      body: child,
    );
  }

  widgetMenu(List<Category>? menu, String assetLottie) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: menu?.length ?? 0,
        itemBuilder: (context, index) {
          var item = menu?[index].name ?? '-';
          return Container(
            color: Colors.white,
            width: 160,
            margin: const EdgeInsets.only(right: 10),
            child: Card(
              color: Colors.white,
              elevation: 6,
              child: Column(
                children: [
                  Lottie.asset(
                    assetLottie,
                    height: 100,
                    width: 150,
                    // fit: BoxFit.contain,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        generateRandomPrice(10000, 70000),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String generateRandomPrice(int start, int end) {
    Random random = Random();

    // Generate a random integer between 100000 and 1000000
    int randomValue = start + random.nextInt(end);

    // Format the integer as Indonesian Rupiah
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    String formattedPrice = formatCurrency.format(randomValue);

    return formattedPrice;
  }
}
