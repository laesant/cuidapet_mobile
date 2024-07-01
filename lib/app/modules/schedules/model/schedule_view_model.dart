import 'package:cuidapet_mobile/app/models/supplier_service_model.dart';

class ScheduleViewModel {
  final int supplierId;
  final List<SupplierServiceModel> services;

  ScheduleViewModel({
    required this.supplierId,
    required this.services,
  });
}
