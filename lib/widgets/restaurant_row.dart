// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_v1/data/api/api_service.dart';

class RestaurantWidget extends StatelessWidget {
  String image;
  String title;
  String location;
  String rating;
  String? heroTag;
  RestaurantWidget({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.rating,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
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
                tag: heroTag ?? image,
                child: CachedNetworkImage(
                  height: 100,
                  width: 100,
                  imageUrl: ApiService().imageUrl(image),
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
