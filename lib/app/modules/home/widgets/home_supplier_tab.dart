part of '../home_page.dart';

class _HomeSupplierTab extends StatelessWidget {
  final HomeController controller;

  const _HomeSupplierTab({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HomeTabHeader(controller),
        Observer(
          builder: (_) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child:
                  controller.supplierPageTypeSelected == SupplierPageType.list
                      ? const _HomeSupplierList()
                      : const _HomeSupplierGrid(),
            );
          },
        )
      ],
    );
  }
}

class _HomeTabHeader extends StatelessWidget {
  const _HomeTabHeader(this.controller);
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          const Text('Estabelecimentos'),
          const Spacer(),
          Observer(
            builder: (_) {
              return IconButton(
                  onPressed: () =>
                      controller.changeTabSupplier(SupplierPageType.list),
                  icon: Icon(
                    Icons.view_headline,
                    color: controller.supplierPageTypeSelected ==
                            SupplierPageType.list
                        ? null
                        : Colors.grey.shade400,
                  ));
            },
          ),
          Observer(
            builder: (_) {
              return IconButton(
                onPressed: () =>
                    controller.changeTabSupplier(SupplierPageType.grid),
                icon: Icon(
                  Icons.view_module,
                  color: controller.supplierPageTypeSelected ==
                          SupplierPageType.grid
                      ? null
                      : Colors.grey.shade400,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class _HomeSupplierList extends StatelessWidget {
  const _HomeSupplierList();

  @override
  Widget build(BuildContext context) {
    return const Text('Supplier List ');
  }
}

class _HomeSupplierGrid extends StatelessWidget {
  const _HomeSupplierGrid();

  @override
  Widget build(BuildContext context) {
    return const Text('Supplier grid');
  }
}
