part of '../../address_page.dart';

typedef AddressSelectedCallback = void Function(PlaceModel);

class _AddressSearchWidget extends StatefulWidget {
  final AddressSelectedCallback addressSelectedCallback;
  final PlaceModel? place;
  const _AddressSearchWidget({
    super.key,
    required this.addressSelectedCallback,
    required this.place,
  });

  @override
  State<_AddressSearchWidget> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<_AddressSearchWidget> {
  final searchEC = TextEditingController();
  final searchFN = FocusNode();

  final controller = Modular.get<AddressSearchController>();

  @override
  void initState() {
    super.initState();
    if (widget.place != null) {
      searchEC.text = widget.place?.address ?? '';
      searchFN.requestFocus();
    }
  }

  @override
  void dispose() {
    searchEC.dispose();
    searchFN.dispose();
    super.dispose();
  }

  FutureOr<List<PlaceModel>?> _suggestionsCallback(String search) {
    if (search.isNotEmpty) {
      return controller.searchAddress(search);
    }
    return [];
  }

  void _onSelected(PlaceModel value) {
    searchEC.text = value.address;
    widget.addressSelectedCallback(value);
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<PlaceModel>(
      controller: searchEC,
      focusNode: searchFN,
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
