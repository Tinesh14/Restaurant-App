import 'package:json_annotation/json_annotation.dart';

part 'customer_review.g.dart';

@JsonSerializable()
class CustomerReviewResult {
  final bool? error;
  final String? message;
  final List<CustomerReview>? customerReviews;

  CustomerReviewResult({
    this.error,
    this.message,
    this.customerReviews,
  });

  factory CustomerReviewResult.fromJson(Map<String, dynamic> json) =>
      _$CustomerReviewResultFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerReviewResultToJson(this);
}

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
