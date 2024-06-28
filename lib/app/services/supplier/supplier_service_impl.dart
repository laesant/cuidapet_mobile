import 'package:cuidapet_mobile/app/models/address_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_nearby_me_model.dart';
import 'package:cuidapet_mobile/app/repositories/supplier/supplier_repository.dart';

import './supplier_service.dart';

class SupplierServiceImpl implements SupplierService {
  final SupplierRepository _supplierRepository;

  SupplierServiceImpl({required SupplierRepository supplierRepository})
      : _supplierRepository = supplierRepository;

  @override
  Future<List<SupplierCategoryModel>> getCategories() =>
      _supplierRepository.getCategories();

  @override
  Future<List<SupplierNearbyMeModel>> findNearbyMe(AddressModel address) =>
      _supplierRepository.findNearbyMe(address);
}
