import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client.dart';
import 'package:cuidapet_mobile/app/models/address_model.dart';
import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageLifeCycleState<HomeController, HomePage> {
  AddressModel? addressModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text('Sair')),
          TextButton(
              onPressed: () async {
                final categoriesResponse =
                    await Modular.get<RestClient>().auth().get('/categories/');
                print(categoriesResponse.data);
              },
              child: const Text('Teste Refresh Token')),
          TextButton(
              onPressed: () async {
                await Modular.to.pushNamed('/address/');
              },
              child: const Text('Ir para endereço')),
          TextButton(
              onPressed: () async {
                final address =
                    await Modular.get<AddressService>().getAddressSelected();
                setState(() {
                  addressModel = address;
                });
              },
              child: const Text('Obter endereço selecionado')),
          Text(addressModel?.address ?? 'Nenhum endereço selecionado'),
          Text(addressModel?.additional ?? 'Nenhum complemento selecionado'),
        ],
      ),
    );
  }
}
