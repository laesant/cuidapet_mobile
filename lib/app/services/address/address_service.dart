import 'package:cuidapet_mobile/app/models/address_model.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';

abstract interface class AddressService {
  Future<List<PlaceModel>> findAddressByGooglePlaces(String addressPattern);
  Future<List<AddressModel>> getAddress();
  Future<AddressModel> saveAddress(PlaceModel place, String additional);
  Future<void> deleteAll();
}
