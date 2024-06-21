import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/models/address_model.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifeCycle {
  final AddressService _addressService;
  @readonly
  AddressModel? _addressModel;

  HomeControllerBase({required AddressService addressService})
      : _addressService = addressService;

  @override
  Future<void> onReady() async {
    Loader.show();
    await _getAddressSelected();
    Loader.hide();
    super.onReady();
  }

  @action
  Future<void> _getAddressSelected() async {
    _addressModel ??= await _addressService.getAddressSelected();

    if (_addressModel == null) {
      await goToAddressPage();
    }
  }

  @action
  Future<void> goToAddressPage() async {
    final address = await Modular.to.pushNamed<AddressModel>('/address/');
    if (address != null) _addressModel = address;
  }
}
