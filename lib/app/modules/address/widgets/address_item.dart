part of '../address_page.dart';

class _AddressItem extends StatelessWidget {
  const _AddressItem({
    required this.address,
    required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: onTap,
        leading: const Icon(Icons.location_on),
        title: Text(address.address),
        subtitle: Text(address.additional),
      ),
    );
  }
}
