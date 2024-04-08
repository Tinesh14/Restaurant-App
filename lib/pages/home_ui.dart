// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app_v1/config/routes/routes.dart';
import 'package:restaurant_app_v1/model/restaurant.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({super.key});

  @override
  _HomeUiState createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  final TextEditingController _searchController = TextEditingController();
  String? filterString;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Restaurant>> loadData({String? filter}) async {
    String jsonString =
        await rootBundle.loadString('assets/local_restaurant.json');
    var json = jsonDecode(jsonString);
    Iterable data = json['restaurants'];
    var list = List<Restaurant>.from(data.map((e) => Restaurant.fromJson(e)));
    if (filter != null && filter.isNotEmpty) {
      return list
          .where((element) =>
                  (element.name?.toLowerCase().contains(filter.toLowerCase()) ??
                      false)
              //     ||
              // (element.city?.toLowerCase().contains(filter.toLowerCase()) ??
              //     false)
              )
          .toList();
    }
    return List<Restaurant>.from(data.map((e) => Restaurant.fromJson(e)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 241, 241),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Restaurant>>(
          future: loadData(filter: filterString),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              var dataRestaurant = snapshot.data;
              return SingleChildScrollView(
                child: Column(
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
                                setState(() {
                                  filterString = null;
                                  _searchController.clear();
                                });
                              }
                            },
                          ),
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              if (_searchController.text.isNotEmpty) {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  filterString = _searchController.text;
                                  // _searchController.clear();
                                });
                              }
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dataRestaurant?.length ?? 0,
                      itemBuilder: (context, index) {
                        var item = dataRestaurant?[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              PageRoutes.detailUi,
                              arguments: item,
                            );
                          },
                          child: widgetRowRestaurant(
                            item?.pictureId ?? '',
                            item?.name ?? '',
                            item?.city ?? '',
                            item?.rating.toString() ?? '',
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  widgetRowRestaurant(
    String image,
    String title,
    String location,
    String rating,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 15,
          ),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Hero(
                tag: image,
                child: CachedNetworkImage(
                  height: 100,
                  width: 100,
                  imageUrl: image,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Restaurant $title",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            location,
                            style: const TextStyle(
                              fontSize: 14,
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
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            rating,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'VAGRoundedStd',
                              fontWeight: FontWeight.w300,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
