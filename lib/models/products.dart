import 'package:boroadwy_2025_session1/models/categories.dart';

class Products {
  int? id;
  String? name;
  double? price;
  String? category;

  Products({
    this.id,
    this.name,
    this.price,
    this.category,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: json['price'] as double?,
      category: json['category'] as String?,
    );
  }
  Map<String, dynamic> toJson(Products product) {
    Map<String, dynamic> json = {};
    json['name'] = product.name;
    json['price'] = product.price;
    json['id'] = product.id;
    json['category'] = product.category;
    return json;
  }
}
