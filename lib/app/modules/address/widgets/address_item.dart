part of '../address_page.dart';

class _AddressItem extends StatelessWidget {
  const _AddressItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(Icons.location_on),
        title: Text('Av. Paulista, 200'),
        subtitle: Text('Completo XX'),
      ),
    );
  }
}
