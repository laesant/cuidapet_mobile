import 'package:cuidapet_mobile/app/models/address_model.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/repositories/address/address_repository.dart';

import './address_service.dart';

class AddressServiceImpl implements AddressService {
  final AddressRepository _addressRepository;

  AddressServiceImpl({required AddressRepository addressRepository})
      : _addressRepository = addressRepository;
  @override
  Future<List<PlaceModel>> findAddressByGooglePlaces(String addressPattern) =>
      _addressRepository.findAddressByGooglePlaces(addressPattern);

  @override
  Future<void> deleteAll() => _addressRepository.deleteAll();

  @override
  Future<List<AddressModel>> getAddress() => _addressRepository.getAddress();

  @override
  Future<AddressModel> saveAddress(PlaceModel place, String additional) async {
    final address = AddressModel(
        address: place.address,
        lat: place.lat,
        lng: place.lng,
        additional: additional);
    int addressId = await _addressRepository.saveAddress(address);
    return address.copyWith(id: () => addressId);
  }
}
