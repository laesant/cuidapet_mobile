import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/messsages.dart';
import 'package:cuidapet_mobile/app/models/address_model.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
part 'address_controller.g.dart';

class AddressController = AddressControllerBase with _$AddressController;

abstract class AddressControllerBase with Store, ControllerLifeCycle {
  final AddressService _addressService;
  @readonly
  List<AddressModel> _addresses = [];

  @readonly
  var _locationServiceUnavailable = false;

  @readonly
  LocationPermission? _locationPermission;

  @readonly
  PlaceModel? _place;

  AddressControllerBase({required AddressService addressService})
      : _addressService = addressService;

  @override
  void onReady() {
    getAddresses();
    super.onReady();
  }

  @action
  Future<void> getAddresses() async {
    Loader.show();
    _addresses = await _addressService.getAddress();
    Loader.hide();
  }

  @action
  Future<void> myLocation() async {
    _locationPermission = null;
    _locationServiceUnavailable = false;
    final serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      _locationServiceUnavailable = true;
      return;
    }

    final locationPermission = await Geolocator.checkPermission();
    switch (locationPermission) {
      case LocationPermission.denied:
        final permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          _locationPermission = permission;
          return;
        }
        break;
      case LocationPermission.deniedForever:
        _locationPermission = locationPermission;
        return;
      case LocationPermission.whileInUse:
      case LocationPermission.always:
      case LocationPermission.unableToDetermine:
        break;
    }

    Loader.show();
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final place = placemark.first;
    final address = '${place.thoroughfare} ${place.subThoroughfare}';
    final placeModel = PlaceModel(
        address: address, lat: position.latitude, lng: position.longitude);
    Loader.hide();
    goToAddressDetail(placeModel);
  }

  Future<void> goToAddressDetail(PlaceModel place) async {
    final address =
        await Modular.to.pushNamed('/address/detail/', arguments: place);

    if (address is PlaceModel) {
      _place = address;
    } else if (address is AddressModel) {
      selectAddress(address);
    }
  }

  Future<void> selectAddress(AddressModel address) async {
    await _addressService.selectAddress(address);
    Modular.to.pop(address);
  }

  Future<void> addressWasSelected() async {
    final address = await _addressService.getAddressSelected();

    if (address != null) {
      Modular.to.pop(address);
    } else {
      Messages.alert('Por favor selecione ou cadastre um endereço');
    }
  }
}
