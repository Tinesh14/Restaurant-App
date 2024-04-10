// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_app_v1/cubit/detail_restaurant_cubit.dart';
import 'package:restaurant_app_v1/cubit/detail_restaurant_state.dart';
import 'package:restaurant_app_v1/data/api/api_service.dart';
import 'package:restaurant_app_v1/data/model/detail_restaurant.dart';
import 'package:restaurant_app_v1/utils/snackbar.dart';
import 'package:restaurant_app_v1/widgets/error.dart';
import 'package:restaurant_app_v1/widgets/loading.dart';
import 'package:restaurant_app_v1/widgets/offline.dart';

import '../data/model/customer_review.dart';
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
  final TextEditingController _nameReviewController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

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
                              "${data.address ?? '-'}, ${data.city ?? '-'}",
                              style: const TextStyle(
                                fontSize: 16,
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
                        height: 20,
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
                      const SizedBox(
                        height: 20,
                      ),
                      widgetMenu(
                        data.menus?.foods,
                        'assets/food_animation.json',
                      ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      widgetMenu(
                        data.menus?.drinks,
                        'assets/drink_animation.json',
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Reviews & Ratings",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              var result = await showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (ctx) {
                                  return SingleChildScrollView(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(25.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller: _nameReviewController,
                                              decoration: InputDecoration(
                                                hintText: 'Enter Name',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.orange,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextField(
                                              controller: _reviewController,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: 4,
                                              minLines: 3,
                                              decoration: InputDecoration(
                                                hintText: 'Enter Review',
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.orange,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                  context,
                                                  {
                                                    'name':
                                                        _nameReviewController
                                                            .text,
                                                    'review':
                                                        _reviewController.text,
                                                  },
                                                );
                                              },
                                              child: const Text(
                                                'Submit Review',
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );

                              if (result != null) {
                                if (result['name'].toString().isNotEmpty ||
                                    result['review'].toString().isNotEmpty) {
                                  var dataReview = {
                                    "id": data.id,
                                    "name": result['name'],
                                    "review": result['review'],
                                  };
                                  FocusScope.of(context).unfocus();
                                  _nameReviewController.clear();
                                  _reviewController.clear();
                                  BlocProvider.of<DetailRestaurantCubit>(
                                          context)
                                      .addReview(
                                    dataReview,
                                  );
                                } else {
                                  showShortSnackBar(
                                      context, 'Data Review tidak lengkap');
                                  FocusScope.of(context).unfocus();
                                  _nameReviewController.clear();
                                  _reviewController.clear();
                                }
                              } else {
                                // setState(() {
                                FocusScope.of(context).unfocus();
                                _nameReviewController.clear();
                                _reviewController.clear();
                                // });
                              }
                            },
                            child: const Text(
                              'Add Review',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  double.parse(data.rating.toString())
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 44,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                RatingBarIndicator(
                                  rating: double.parse(data.rating.toString()),
                                  itemSize: 16,
                                  unratedColor:
                                      const Color.fromARGB(255, 226, 223, 223),
                                  itemBuilder: (context, index) {
                                    return const Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              children: [
                                RatingIndicator(
                                  rating: "5",
                                  value: 0.8,
                                ),
                                RatingIndicator(
                                  rating: "4",
                                  value: 0.6,
                                ),
                                RatingIndicator(
                                  rating: "3",
                                  value: 0.2,
                                ),
                                RatingIndicator(
                                  rating: "2",
                                  value: 0.1,
                                ),
                                RatingIndicator(
                                  rating: "1",
                                  value: 0.1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.customerReviews?.length ?? 0,
                        itemBuilder: (context, index) {
                          var reviews = data.customerReviews?[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Card(
                              color: Colors.white,
                              elevation: 6,
                              child: UserReview(
                                rating: data.rating,
                                reviews: reviews,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
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
        listener: (context, state) {
          if (state is DetailRestaurantMessage) {
            showShortSnackBar(context, state.message);
          }
        },
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

class RatingIndicator extends StatelessWidget {
  String rating;
  double value;
  RatingIndicator({
    super.key,
    required this.rating,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            rating,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 12,
          child: SizedBox(
            child: LinearProgressIndicator(
              value: value,
              minHeight: 11,
              backgroundColor: const Color.fromARGB(255, 226, 223, 223),
              borderRadius: BorderRadius.circular(7),
              valueColor: const AlwaysStoppedAnimation(
                Colors.orange,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UserReview extends StatelessWidget {
  dynamic rating;
  CustomerReview? reviews;
  UserReview({
    super.key,
    required this.rating,
    required this.reviews,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Lottie.asset(
              'assets/man_animation.json',
              width: 50,
              height: 50,
            ),
            Text(
              reviews?.name ?? '-',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12,
          ),
          child: Row(
            children: [
              RatingBarIndicator(
                rating: double.parse(rating.toString()),
                itemSize: 16,
                unratedColor: const Color.fromARGB(255, 226, 223, 223),
                itemBuilder: (context, index) {
                  return const Icon(
                    Icons.star,
                    color: Colors.orange,
                  );
                },
              ),
              const SizedBox(
                width: 20,
              ),
              Text(reviews?.date ?? '-'),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12,
          ),
          child: ReadMoreText(
            reviews?.review ?? '-',
            trimMode: TrimMode.Line,
            trimLines: 4,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
