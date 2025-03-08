import 'dart:convert';

Catelog catelogFromJson(String str) => Catelog.fromJson(json.decode(str));

String catelogToJson(Catelog data) => json.encode(data.toJson());

class Catelog {
  List<MensClothe>? mensClothes;

  Catelog({
    this.mensClothes,
  });

  factory Catelog.fromJson(Map<String, dynamic> json) => Catelog(
    mensClothes: json["mens_clothes"] == null ? [] : List<MensClothe>.from(json["mens_clothes"]!.map((x) => MensClothe.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mens_clothes": mensClothes == null ? [] : List<dynamic>.from(mensClothes!.map((x) => x.toJson())),
  };
}

class MensClothe {
  String? productName;
  String? imageUrl;
  int? price;
  int? discountPrice;
  List<String>? colors;

  MensClothe({
    this.productName,
    this.imageUrl,
    this.price,
    this.discountPrice,
    this.colors,
  });

  factory MensClothe.fromJson(Map<String, dynamic> json) => MensClothe(
    productName: json["product_name"],
    imageUrl: json["image_url"],
    price: json["price"],
    discountPrice: json["discount_price"],
    colors: json["colors"] == null ? [] : List<String>.from(json["colors"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "product_name": productName,
    "image_url": imageUrl,
    "price": price,
    "discount_price": discountPrice,
    "colors": colors == null ? [] : List<dynamic>.from(colors!.map((x) => x)),
  };
}
