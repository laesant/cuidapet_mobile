import 'dart:convert';

import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';

class SupplierModel {
  final int id;
  final String name;
  final String logo;
  final String address;
  final String phone;
  final double latitude;
  final double longitude;
  final SupplierCategoryModel category;
  SupplierModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.address,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'address': address,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'category': category.toMap(),
    };
  }

  factory SupplierModel.fromMap(Map<String, dynamic> map) {
    return SupplierModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      logo: map['logo'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      category: SupplierCategoryModel.fromMap(map['category']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplierModel.fromJson(String source) =>
      SupplierModel.fromMap(json.decode(source));
}
