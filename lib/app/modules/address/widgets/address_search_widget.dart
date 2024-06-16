part of '../address_page.dart';

class _AddressSearchWidget extends StatefulWidget {
  const _AddressSearchWidget();

  @override
  State<_AddressSearchWidget> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<_AddressSearchWidget> {
  FutureOr<List<PlaceModel>?> _suggestionsCallback(String search) {
    return [
      PlaceModel(address: 'Av Paulista, 200', lat: 123.09, lng: 233.32),
      PlaceModel(address: 'Av Paulista, 300', lat: 123.09, lng: 233.32),
    ];
  }

  void _onSelected(PlaceModel? value) {}

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<PlaceModel>(
      onSelected: _onSelected,
      suggestionsCallback: _suggestionsCallback,
      itemBuilder: (BuildContext context, value) {
        return _ItemTile(
          address: value.address,
        );
      },
      builder: (context, controller, focusNode) => Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: 'Insira um endereço',
            prefixIcon: const Icon(Icons.location_on),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({required this.address});
  final String address;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: Text(address),
    );
  }
}
