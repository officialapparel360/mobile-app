import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  List<Datum>? data;

  ProductModel({
    this.data,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? name;
  double? price;
  double? salePrice;
  int? discount;
  String? shortDetails;
  String? description;
  int? stock;
  int? isNew;
  int? isSale;
  dynamic category;
  List<String>? pictures;
  List<String>? colors;
  List<String>? size;

  Datum({
    this.id,
    this.name,
    this.price,
    this.salePrice,
    this.discount,
    this.shortDetails,
    this.description,
    this.stock,
    this.isNew,
    this.isSale,
    this.category,
    this.pictures,
    this.colors,
    this.size,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    salePrice: json["salePrice"],
    discount: json["discount"],
    shortDetails: json["shortDetails"],
    description: json["description"],
    stock: json["stock"],
    isNew: json["isNew"],
    isSale: json["isSale"],
    category: json["category"],
    pictures: json["pictures"] == null ? [] : List<String>.from(json["pictures"]!.map((x) => x)),
    colors: json["colors"] == null ? [] : List<String>.from(json["colors"]!.map((x) => x)),
    size: json["size"] == null ? [] : List<String>.from(json["size"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "salePrice": salePrice,
    "discount": discount,
    "shortDetails": shortDetails,
    "description": description,
    "stock": stock,
    "isNew": isNew,
    "isSale": isSale,
    "category": category,
    "pictures": pictures == null ? [] : List<dynamic>.from(pictures!.map((x) => x)),
    "colors": colors == null ? [] : List<dynamic>.from(colors!.map((x) => x)),
    "size": size == null ? [] : List<dynamic>.from(size!.map((x) => x)),
  };
}
