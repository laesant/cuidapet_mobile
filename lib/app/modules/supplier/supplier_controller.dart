import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/messsages.dart';
import 'package:cuidapet_mobile/app/models/supplier_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_service_model.dart';
import 'package:cuidapet_mobile/app/modules/schedules/model/schedule_view_model.dart';
import 'package:cuidapet_mobile/app/services/supplier/supplier_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';
part 'supplier_controller.g.dart';

class SupplierController = SupplierControllerBase with _$SupplierController;

abstract class SupplierControllerBase with Store, ControllerLifeCycle {
  final SupplierService _supplierService;
  final AppLogger _log;

  int _supplierId = -1;

  @readonly
  SupplierModel? _supplierModel;

  @readonly
  var _supplierServices = <SupplierServiceModel>[];

  @readonly
  var _servicesSelected = <SupplierServiceModel>[].asObservable();

  SupplierControllerBase(
      {required SupplierService supplierService, required AppLogger log})
      : _supplierService = supplierService,
        _log = log;

  @override
  void onInit(Map<String, dynamic>? params) {
    super.onInit(params);
    _supplierId = params?['supplierId'] ?? -1;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    try {
      Loader.show();
      await Future.wait([
        _findSupplierById(),
        _findSupplierServices(),
      ]);
    } finally {
      Loader.hide();
    }
  }

  @action
  Future<void> _findSupplierById() async {
    try {
      _supplierModel = await _supplierService.findById(_supplierId);
    } catch (e, s) {
      _log.error('Erro ao buscar dados do fornecedor', e, s);
      Messages.alert('Erro ao buscar dados do fornecedor');
    }
  }

  @action
  Future<void> _findSupplierServices() async {
    try {
      _supplierServices = await _supplierService.findServices(_supplierId);
    } catch (e, s) {
      _log.error('Erro ao buscar serviços do fornecedor', e, s);
      Messages.alert('Erro ao buscar serviços do fornecedor');
    }
  }

  @action
  void addOrRemoveService(SupplierServiceModel supplierService) {
    if (_servicesSelected.contains(supplierService)) {
      _servicesSelected.remove(supplierService);
    } else {
      _servicesSelected.add(supplierService);
    }
  }

  bool isServiceSelected(SupplierServiceModel supplierService) =>
      _servicesSelected.contains(supplierService);

  int get totalServicesSelected => _servicesSelected.length;

  Future<void> goToPhoneOrCopyPhoneToClipart() async {
    final phoneUrl = 'tel:${_supplierModel?.phone}';

    if (await canLaunchUrlString(phoneUrl)) {
      await launchUrlString(phoneUrl);
    } else {
      await Clipboard.setData(ClipboardData(text: _supplierModel?.phone ?? ''));
      Messages.info('Telefone copiado!');
    }
  }

  Future<void> goToGeoOrCopyAddressToClipart() async {
    final geoUrl =
        'geo:${_supplierModel?.latitude},${_supplierModel?.longitude}';
    if (await canLaunchUrlString(geoUrl)) {
      await launchUrlString(geoUrl);
    } else {
      await Clipboard.setData(
          ClipboardData(text: _supplierModel?.address ?? ''));
      Messages.info('Endereço copiado!');
    }
  }

  void goToSchedule() {
    Modular.to.pushNamed(
      '/schedules/',
      arguments: ScheduleViewModel(
        supplierId: _supplierId,
        services: _servicesSelected.toList(),
      ),
    );
  }
}
