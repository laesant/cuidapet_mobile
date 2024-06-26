import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';

abstract interface class SupplierRepository {
  Future<List<SupplierCategoryModel>> getCategories();
}