import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/supplier_model.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_controller.dart';
import 'package:flutter/material.dart';

class SupplierDetail extends StatelessWidget {
  const SupplierDetail(
      {super.key, required this.supplier, required this.supplierController});
  final SupplierModel supplier;
  final SupplierController supplierController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Center(
            child: Text(
              supplier.name,
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge,
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: context.primaryColor,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Informações do estabelecimento',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.location_city),
          title: Text(supplier.address),
          onTap: supplierController.goToGeoOrCopyAddressToClipart,
        ),
        ListTile(
          leading: const Icon(Icons.phone),
          title: Text(supplier.phone),
          onTap: supplierController.goToPhoneOrCopyPhoneToClipart,
        ),
        Divider(
          thickness: 1,
          color: context.primaryColor,
        ),
      ],
    );
  }
}
