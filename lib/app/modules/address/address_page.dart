import 'dart:async';
import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/core/mixins/location_mixin.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/modules/address/address_controller.dart';
import 'package:cuidapet_mobile/app/modules/address/widgets/address_search_widget/address_search_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

part 'widgets/address_item.dart';
part 'widgets/address_search_widget/address_search_widget.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState
    extends PageLifeCycleState<AddressController, AddressPage>
    with LocationMixin {
  final reactionDisposers = <ReactionDisposer>[];
  @override
  void initState() {
    super.initState();
    final reactionService = reaction<bool>(
      (_) => controller.locationServiceUnavailable,
      (locationServiceUnavailable) {
        if (locationServiceUnavailable) {
          showDialogLocationServiceUnavailable();
        }
      },
    );
    final reactionLocationPermission = reaction<LocationPermission?>(
      (_) => controller.locationPermission,
      (locationPermission) {
        if (locationPermission != null &&
            locationPermission == LocationPermission.denied) {
          showDialogLocationDenied(tryAgain: () => controller.myLocation());
        } else if (locationPermission != null &&
            locationPermission == LocationPermission.deniedForever) {
          showDialogLocationDeniedForever();
        }
      },
    );

    reactionDisposers.addAll([reactionService, reactionLocationPermission]);
  }

  @override
  void dispose() {
    for (var reactionDisposer in reactionDisposers) {
      reactionDisposer();
    }
    super.dispose();
  }

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
                controller.goToAddressDetail(place);
              },
            ),
            const SizedBox(height: 30),
            ListTile(
              onTap: () => controller.myLocation(),
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
            Observer(
              builder: (_) {
                return Column(
                  children: controller.addresses
                      .map((address) => _ItemTile(address: address.address))
                      .toList(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
