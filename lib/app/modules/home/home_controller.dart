import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/messsages.dart';
import 'package:cuidapet_mobile/app/models/address_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_nearby_me_model.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:cuidapet_mobile/app/services/supplier/supplier_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

enum SupplierPageType { list, grid }

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifeCycle {
  final AddressService _addressService;
  final SupplierService _supplierService;

  @readonly
  AddressModel? _addressModel;

  @readonly
  var _listCategories = <SupplierCategoryModel>[];

  @readonly
  var _supplierPageTypeSelected = SupplierPageType.list;

  @readonly
  var _listSuppliersByAddress = <SupplierNearbyMeModel>[];

  late final ReactionDisposer findSuppliersReactionDisposer;

  HomeControllerBase(
      {required AddressService addressService,
      required SupplierService supplierService})
      : _addressService = addressService,
        _supplierService = supplierService;

  @override
  void onInit(Map<String, dynamic>? params) {
    super.onInit(params);
    findSuppliersReactionDisposer =
        reaction((_) => _addressModel, (_) => findSupplierByAddress());
  }

  @override
  Future<void> onReady() async {
    try {
      Loader.show();
      await _getAddressSelected();
      await _getCategories();
    } finally {
      Loader.hide();
    }
    super.onReady();
  }

  @override
  void dispose() {
    findSuppliersReactionDisposer();
    super.dispose();
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

  @action
  Future<void> _getCategories() async {
    try {
      final categories = await _supplierService.getCategories();
      _listCategories = [...categories];
    } catch (_) {
      Messages.alert('Erro ao buscar as categorias.');
      throw Exception();
    }
  }

  @action
  void changeTabSupplier(SupplierPageType pageType) =>
      _supplierPageTypeSelected = pageType;

  @action
  Future<void> findSupplierByAddress() async {
    if (_addressModel != null) {
      final suppliers = await _supplierService.findNearbyMe(_addressModel!);
      _listSuppliersByAddress = [...suppliers];
    } else {
      Messages.alert(
          'Para realizar a busca de petshops você precisa selecionar um endereço');
    }
  }
}
