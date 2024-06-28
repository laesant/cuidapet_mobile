import 'dart:convert';

class SupplierNearbyMeModel {
  final int id;
  final String name;
  final String logo;
  final double distance;
  final int category;
  
  SupplierNearbyMeModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.distance,
    required this.category,
  });

  SupplierNearbyMeModel copyWith({
    int? id,
    String? name,
    String? logo,
    double? distance,
    int? category,
  }) {
    return SupplierNearbyMeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      distance: distance ?? this.distance,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'distance': distance,
      'category': category,
    };
  }

  factory SupplierNearbyMeModel.fromMap(Map<String, dynamic> map) {
    return SupplierNearbyMeModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      logo: map['logo'] ?? '',
      distance: map['distance']?.toDouble() ?? 0.0,
      category: map['category']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplierNearbyMeModel.fromJson(String source) =>
      SupplierNearbyMeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SupplierNearbyMeModel(id: $id, name: $name, logo: $logo, distance: $distance, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SupplierNearbyMeModel &&
        other.id == id &&
        other.name == name &&
        other.logo == logo &&
        other.distance == distance &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        logo.hashCode ^
        distance.hashCode ^
        category.hashCode;
  }
}
