import 'package:json_annotation/json_annotation.dart';

part 'customer_review.g.dart';

@JsonSerializable()
class CustomerReview {
  final String? name;
  final String? review;
  final String? date;

  CustomerReview({
    this.name,
    this.review,
    this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) =>
      _$CustomerReviewFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerReviewToJson(this);
}
