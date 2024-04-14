// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app_v1/cubit/list_restaurant_cubit.dart';
import 'package:restaurant_app_v1/cubit/list_restaurant_state.dart';
import 'package:restaurant_app_v1/data/api/api_service.dart';
import 'package:restaurant_app_v1/utils/snackbar.dart';
import 'package:restaurant_app_v1/widgets/empty.dart';
import 'package:restaurant_app_v1/widgets/error.dart';
import 'package:restaurant_app_v1/widgets/loading.dart';
import 'package:restaurant_app_v1/widgets/offline.dart';
import 'package:restaurant_app_v1/widgets/restaurant_row.dart';

import '../common/routes.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({super.key});

  @override
  _HomeUiState createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  final TextEditingController _searchController = TextEditingController();
  String? filterString;
  ListRestaurantCubit? cubitListRestaurant;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                "Restaurant",
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      if (cubitListRestaurant != null) {
                        cubitListRestaurant?.init(isLoad: true);
                      }
                    }
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.orange,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintText: 'Search restaurant name ...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        if (_searchController.text.isNotEmpty) {
                          FocusScope.of(context).unfocus();
                          _searchController.clear();
                          if (cubitListRestaurant != null) {
                            cubitListRestaurant?.init(isLoad: true);
                          }
                        }
                      },
                    ),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        if (_searchController.text.isNotEmpty) {
                          FocusScope.of(context).unfocus();
                          if (cubitListRestaurant != null) {
                            cubitListRestaurant?.search(_searchController.text);
                          }
                        } else {
                          showShortSnackBar(
                              context, 'Silahkan isi search input');
                        }
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocProvider<ListRestaurantCubit>(
                create: (context) => ListRestaurantCubit(
                  ApiService(),
                ),
                child: BlocConsumer<ListRestaurantCubit, ListRestaurantState>(
                  builder: (context, state) {
                    cubitListRestaurant =
                        BlocProvider.of<ListRestaurantCubit>(context);
                    if (state is ListRestaurantLoading) {
                      return const LoadingAnimation();
                    } else if (state is ListRestaurantEmpty) {
                      return const EmptyAnimation();
                    } else if (state is ListRestaurantError) {
                      return ErrorAnimation(
                        onPressed: () {
                          cubitListRestaurant?.init(isLoad: true);
                        },
                        message: state.message,
                      );
                    } else if (state is ListRestaurantOffline) {
                      return OfflineAnimation(
                        onPressed: () {
                          cubitListRestaurant?.init(isLoad: true);
                        },
                      );
                    } else if (state is ListRestaurantSuccess) {
                      var dataRestaurant = state.dataRestaurant;
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dataRestaurant.length,
                        itemBuilder: (context, index) {
                          var item = dataRestaurant[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PageRoutes.detailUi,
                                arguments: {
                                  "id": item.id ?? "",
                                  "data": null,
                                },
                              );
                            },
                            child: RestaurantWidget(
                              image: item.pictureId ?? '',
                              title: item.name ?? '',
                              location: item.city ?? '',
                              rating: item.rating.toString(),
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
