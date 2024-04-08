import 'dart:convert';

Restaurant restaurantFromJson(String str) =>
    Restaurant.fromJson(json.decode(str));

String restaurantToJson(Restaurant data) => json.encode(data.toJson());

class Restaurant {
  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  dynamic rating;
  Menus? menus;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  Restaurant copyWith({
    String? id,
    String? name,
    String? description,
    String? pictureId,
    String? city,
    dynamic rating,
    Menus? menus,
  }) =>
      Restaurant(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        pictureId: pictureId ?? this.pictureId,
        city: city ?? this.city,
        rating: rating ?? this.rating,
        menus: menus ?? this.menus,
      );

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"],
        menus: json["menus"] == null ? null : Menus.fromJson(json["menus"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "menus": menus?.toJson(),
      };
}

class Menus {
  List<Food>? foods;
  List<Drink>? drinks;

  Menus({
    this.foods,
    this.drinks,
  });

  Menus copyWith({
    List<Food>? foods,
    List<Drink>? drinks,
  }) =>
      Menus(
        foods: foods ?? this.foods,
        drinks: drinks ?? this.drinks,
      );

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: json["foods"] == null
            ? []
            : List<Food>.from(json["foods"]!.map((x) => Food.fromJson(x))),
        drinks: json["drinks"] == null
            ? []
            : List<Drink>.from(json["drinks"]!.map((x) => Drink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": foods == null
            ? []
            : List<dynamic>.from(foods!.map((x) => x.toJson())),
        "drinks": drinks == null
            ? []
            : List<dynamic>.from(drinks!.map((x) => x.toJson())),
      };
}

class Drink {
  String? name;

  Drink({
    this.name,
  });

  Drink copyWith({
    String? name,
  }) =>
      Drink(
        name: name ?? this.name,
      );

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Food {
  String? name;

  Food({
    this.name,
  });

  Food copyWith({
    String? name,
  }) =>
      Food(
        name: name ?? this.name,
      );

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
