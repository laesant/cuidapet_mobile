import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

part 'widgets/address_item.dart';

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
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(20),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            const SizedBox(height: 20),
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
