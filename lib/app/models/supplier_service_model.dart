import 'dart:convert';

class SupplierServiceModel {
  final int id;
  final int supplierId;
  final String name;
  final double price;

  SupplierServiceModel({
    required this.id,
    required this.supplierId,
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'supplier_id': supplierId,
      'name': name,
      'price': price,
    };
  }

  factory SupplierServiceModel.fromMap(Map<String, dynamic> map) {
    return SupplierServiceModel(
      id: map['id']?.toInt() ?? 0,
      supplierId: map['supplier_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplierServiceModel.fromJson(String source) =>
      SupplierServiceModel.fromMap(json.decode(source));
}
