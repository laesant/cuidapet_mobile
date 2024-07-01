import 'package:cuidapet_mobile/app/models/address_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_nearby_me_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_service_model.dart';

abstract interface class SupplierService {
Future<List<SupplierCategoryModel>> getCategories();
Future<List<SupplierNearbyMeModel>> findNearbyMe(AddressModel address);
  Future<SupplierModel> findById(int id);
  Future<List<SupplierServiceModel>> findServices(int supplierId);
}