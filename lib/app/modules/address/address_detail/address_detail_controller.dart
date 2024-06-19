import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/models/address_model.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:mobx/mobx.dart';
part 'address_detail_controller.g.dart';

class AddressDetailController = AddressDetailControllerBase
    with _$AddressDetailController;

abstract class AddressDetailControllerBase with Store {
  final AddressService _addressService;
  @readonly
  AddressModel? _address;

  AddressDetailControllerBase({required AddressService addressService})
      : _addressService = addressService;

  Future<void> saveAddress(PlaceModel place, String additional) async {
    Loader.show();
    final address = await _addressService.saveAddress(place, additional);
    Loader.hide();
    _address = address;
  }
}
