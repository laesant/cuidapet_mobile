import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class SupplierServiceWidget extends StatelessWidget {
  const SupplierServiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.pets),
      ),
      title: Text('BANHO'),
      subtitle: Text('R\$ 10,00'),
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
