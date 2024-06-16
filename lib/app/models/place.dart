class Place {
  String address;
  double lat;
  double lng;
  Place({
    required this.address,
    required this.lat,
    required this.lng,
  });

  @override
  String toString() => 'Place(address: $address, lat: $lat, lng: $lng)';
}
