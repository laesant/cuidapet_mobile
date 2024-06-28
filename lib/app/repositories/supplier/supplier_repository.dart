import 'package:cuidapet_mobile/app/models/address_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_nearby_me_model.dart';

abstract interface class SupplierRepository {
  Future<List<SupplierCategoryModel>> getCategories();
  Future<List<SupplierNearbyMeModel>> findNearbyMe(AddressModel address);
}