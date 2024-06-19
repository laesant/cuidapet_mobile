import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_default_button.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/modules/address/address_detail/address_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

class AddressDetailPage extends StatefulWidget {
  const AddressDetailPage({super.key, required this.place});
  final PlaceModel place;
  @override
  State<AddressDetailPage> createState() => _AddressDetailPageState();
}

class _AddressDetailPageState extends State<AddressDetailPage> {
  final additionalEC = TextEditingController();
  final controller = Modular.get<AddressDetailController>();
  late final ReactionDisposer addressDisposer;
  @override
  void initState() {
    super.initState();
    addressDisposer = reaction(
      (_) => controller.address,
      (address) {
        if (address != null) {
          Navigator.of(context).pop(address);
        }
      },
    );
  }

  @override
  void dispose() {
    additionalEC.dispose();
    addressDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text(
              'Confirme seu endereço',
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  zoom: 16,
                  target: LatLng(
                    widget.place.lat,
                    widget.place.lng,
                  ),
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('AddressID'),
                    position: LatLng(
                      widget.place.lat,
                      widget.place.lng,
                    ),
                    infoWindow: InfoWindow(title: widget.place.address),
                  )
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                readOnly: true,
                initialValue: widget.place.address,
                decoration: const InputDecoration(
                  labelText: 'Endereço',
                  suffixIcon: Icon(Icons.edit),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: additionalEC,
                decoration: const InputDecoration(
                  labelText: 'Complemento',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: .9.sw,
                height: 60.h,
                child: CuidapetDefaultButton(
                    onPressed: () {
                      controller.saveAddress(widget.place, additionalEC.text);
                    },
                    label: 'Salvar'),
              ),
            )
          ],
        ));
  }
}
