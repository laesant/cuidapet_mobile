import 'package:cuidapet_mobile/app/models/address_model.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';

abstract interface class AddressRepository {
  Future<List<PlaceModel>> findAddressByGooglePlaces(String addressPattern);
  Future<List<AddressModel>> getAddress();
  Future<int> saveAddress(AddressModel address);
  Future<void> deleteAll();
}
