import 'dart:async';
import 'package:cuidapet_mobile/app/core/database/sqlite_connection_factory.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/modules/address/widgets/address_search_widget/address_search_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';

part 'widgets/address_item.dart';
part 'widgets/address_search_widget/address_search_widget.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              'Adicione ou escolha um endereço',
              style: context.textTheme.headlineLarge,
            ),
            const SizedBox(height: 20),
            _AddressSearchWidget(
              addressSelectedCallback: (place) {
                Modular.to.pushNamed('/address/detail/', arguments: place);
              },
            ),
            const SizedBox(height: 30),
            ListTile(
              onTap: () {},
              leading: const CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.near_me,
                ),
              ),
              title: const Text(
                'Localização Atual',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const SizedBox(height: 20),
            const Column(
              children: [
                _AddressItem(),
                _AddressItem(),
                _AddressItem(),
                _AddressItem(),
                _AddressItem(),
                _AddressItem(),
                _AddressItem(),
                _AddressItem(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
