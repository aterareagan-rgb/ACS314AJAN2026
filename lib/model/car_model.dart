import 'package:flutter/material.dart';

class CarModel {
  final String name;
  final String year;
  final String price;
  final String type;
  final IconData image;

  CarModel({
    required this.name,
    required this.year,
    required this.price,
    required this.type,
    required this.image,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      name: json['name'],
      year: json['year'],
      price: json['price'],
      type: json['type'],
      image: json['image'],
    );
  }
}
