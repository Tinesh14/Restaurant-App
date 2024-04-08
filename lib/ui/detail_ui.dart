// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';

import '../data/model/restaurant.dart';
import '../widgets/appbar.dart';

class DetailUi extends StatefulWidget {
  Restaurant item;
  DetailUi({
    super.key,
    required this.item,
  });

  @override
  State<DetailUi> createState() => _DetailUiState();
}

class _DetailUiState extends State<DetailUi> {
  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      tag: widget.item.pictureId ?? 'image',
      titleAppBar: widget.item.name ?? '',
      urlImage: widget.item.pictureId ?? '',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Restaurant ${widget.item.name ?? ''}",
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
                      widget.item.city ?? '-',
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
                widget.item.description ?? '-',
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
              SizedBox(
                height: 180,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.item.menus?.foods?.length ?? 0,
                  itemBuilder: (context, index) {
                    var foodItem = widget.item.menus?.foods?[index].name ?? '-';
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
                              'assets/food_animation.json',
                              height: 100,
                              width: 150,
                              // fit: BoxFit.contain,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  foodItem,
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
                                  generateRandomPrice(50000, 250000),
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
              SizedBox(
                height: 180,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.item.menus?.drinks?.length ?? 0,
                  itemBuilder: (context, index) {
                    var drinkItem =
                        widget.item.menus?.drinks?[index].name ?? '-';
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
                              'assets/drink_animation.json',
                              height: 100,
                              width: 150,
                              // fit: BoxFit.contain,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  drinkItem,
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
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
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
