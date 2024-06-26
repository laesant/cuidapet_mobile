import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client_exception.dart';
import 'package:cuidapet_mobile/app/models/address_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_nearby_me_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_service_model.dart';

import './supplier_repository.dart';

class SupplierRepositoryImpl implements SupplierRepository {
  final RestClient _restClient;
  final AppLogger _log;

  SupplierRepositoryImpl(
      {required RestClient restClient, required AppLogger log})
      : _restClient = restClient,
        _log = log;

  @override
  Future<List<SupplierCategoryModel>> getCategories() async {
    try {
      final result = await _restClient.auth().get('/categories/');
      return result.data
          ?.map<SupplierCategoryModel>(
              (categoryMap) => SupplierCategoryModel.fromMap(categoryMap))
          .toList();
    } on RestClientException catch (e, s) {
      const msg = 'Erro ao buscar categorias dos fornecedores.';
      _log.error(msg, e, s);
      throw Failure(message: msg);
    }
  }

  @override
  Future<List<SupplierNearbyMeModel>> findNearbyMe(AddressModel address) async {
    try {
      final result =
          await _restClient.auth().get('/suppliers/', queryParameters: {
        'lat': address.lat,
        'lng': address.lng,
      });
      return result.data
          .map<SupplierNearbyMeModel>(
              (supplier) => SupplierNearbyMeModel.fromMap(supplier))
          .toList();
    } on RestClientException catch (e, s) {
      var message = 'Erro ao buscar fornecedores perto de mim';
      _log.error(message, e, s);
      throw Failure(message: message);
    }
  }

  @override
  Future<SupplierModel> findById(int id) async {
    try {
      final result = await _restClient.auth().get('/suppliers/$id');
      return SupplierModel.fromMap(result.data);
    } on RestClientException catch (e, s) {
      _log.error('Erro ao buscar dados do fornecedor por id', e, s);
      throw Failure(message: 'Erro ao buscar dados do fornecedor por id');
    }
  }

  @override
  Future<List<SupplierServiceModel>> findServices(int supplierId) async {
    try {
      final result =
          await _restClient.auth().get('/suppliers/$supplierId/services');
      return result.data
              ?.map<SupplierServiceModel>(
                  (json) => SupplierServiceModel.fromMap(json))
              .toList() ??
          <SupplierServiceModel>[];
    } on RestClientException catch (e, s) {
      _log.error('Erro ao buscar os serviços do fornecedor', e, s);
      throw Failure(message: 'Erro ao buscar os serviços do fornecedor');
    }
  }
}
