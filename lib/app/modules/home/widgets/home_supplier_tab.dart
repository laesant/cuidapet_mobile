part of '../home_page.dart';

class _HomeSupplierTab extends StatelessWidget {
  final HomeController controller;

  const _HomeSupplierTab({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HomeTabHeader(controller),
        Expanded(
          child: Observer(
            builder: (_) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child:
                    controller.supplierPageTypeSelected == SupplierPageType.list
                        ? _HomeSupplierList(controller)
                        : _HomeSupplierGrid(controller),
              );
            },
          ),
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
  const _HomeSupplierList(this._controller);
  final HomeController _controller;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Observer(
          builder: (_) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: _controller.listSuppliersByAddress.length,
                (context, index) {
                  final SupplierNearbyMeModel supplier =
                      _controller.listSuppliersByAddress[index];
                  return _HomeSupplierListItemWidget(supplier);
                },
              ),
            );
          },
        )
      ],
    );
  }
}

class _HomeSupplierListItemWidget extends StatelessWidget {
  const _HomeSupplierListItemWidget(this.supplier);
  final SupplierNearbyMeModel supplier;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Stack(
        children: [
          Container(
            height: 80.h,
            width: 1.sw,
            margin: const EdgeInsets.only(left: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          supplier.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16),
                            Text(
                                '${supplier.distance.toStringAsFixed(2)}km de distância'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: CircleAvatar(
                      backgroundColor: context.primaryColorLight,
                      maxRadius: 15,
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      )),
                )
              ],
            ),
          ),
          Container(
            width: 70,
            height: 70,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                width: 1,
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5,
                  color: Colors.grey.shade100,
                ),
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(supplier.logo),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeSupplierGrid extends StatelessWidget {
  const _HomeSupplierGrid(this._controller);
  final HomeController _controller;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Observer(
          builder: (_) {
            return SliverGrid.builder(
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final supplier = _controller.listSuppliersByAddress[index];
                return _HomeSupplierCardItemWidget(supplier);
              },
            );
          },
        )
      ],
    );
  }
}

class _HomeSupplierCardItemWidget extends StatelessWidget {
  const _HomeSupplierCardItemWidget(this.supplier);
  final SupplierNearbyMeModel supplier;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin:
              const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
          child: SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, right: 10, left: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    supplier.name,
                    style: context.textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${supplier.distance.toStringAsFixed(2)}km de distância',
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                supplier.logo,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
