import 'package:cuidapet_mobile/app/core/helpers/text_formatter.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/supplier_service_model.dart';
import 'package:flutter/material.dart';

class SupplierServiceWidget extends StatelessWidget {
  const SupplierServiceWidget({super.key, required this.supplierService});
  final SupplierServiceModel supplierService;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.pets),
      ),
      title: Text(supplierService.name),
      subtitle: Text(TextFormatter.formatReal(supplierService.price)),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.add_circle,
          size: 30,
          color: context.primaryColor,
        ),
      ),
    );
  }
}
