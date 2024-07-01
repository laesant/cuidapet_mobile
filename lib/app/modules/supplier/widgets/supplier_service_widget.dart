import 'package:cuidapet_mobile/app/core/helpers/text_formatter.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/supplier_service_model.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SupplierServiceWidget extends StatelessWidget {
  const SupplierServiceWidget(
      {super.key,
      required this.supplierService,
      required this.supplierController});
  final SupplierServiceModel supplierService;
  final SupplierController supplierController;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.pets),
      ),
      title: Text(supplierService.name),
      subtitle: Text(TextFormatter.formatReal(supplierService.price)),
      trailing: Observer(
        builder: (_) {
          return IconButton(
            onPressed: () {
              supplierController.addOrRemoveService(supplierService);
            },
            icon: supplierController.isServiceSelected(supplierService)
                ? const Icon(
                    Icons.remove_circle,
                    size: 30,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.add_circle,
                    size: 30,
                    color: context.primaryColor,
                  ),
          );
        },
      ),
    );
  }
}
