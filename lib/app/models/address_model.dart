import 'dart:convert';

import 'package:flutter/widgets.dart';

class AddressModel {
  final int? id;
  final String address;
  final double lat;
  final double lng;
  final String additional;

  AddressModel({
    this.id,
    required this.address,
    required this.lat,
    required this.lng,
    required this.additional,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'lat': lat,
      'lng': lng,
      'additional': additional,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id']?.toInt(),
      address: map['address'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      additional: map['additional'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source));

  AddressModel copyWith({
    ValueGetter<int?>? id,
    String? address,
    double? lat,
    double? lng,
    String? additional,
  }) {
    return AddressModel(
      id: id != null ? id() : this.id,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      additional: additional ?? this.additional,
    );
  }
}
