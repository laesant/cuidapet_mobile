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
                        ? const _HomeSupplierList()
                        : const _HomeSupplierGrid(),
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
  const _HomeSupplierList();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 10,
            (context, index) {
              return _HomeSupplierListItemWidget();
            },
          ),
        ),
      ],
    );
  }
}

class _HomeSupplierListItemWidget extends StatelessWidget {
  const _HomeSupplierListItemWidget();

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
                          'Clinica Central ABC',
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16),
                            Text('1.34km de distância'),
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
                image: const DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQskONOFOspkbTbOrVbW2yONt1S5rPIRzcdNA&shttps://img.nsctotal.com.br/wp-content/uploads/2023/12/Golden-retriever.jpg'),
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
  const _HomeSupplierGrid();

  @override
  Widget build(BuildContext context) {
    return const Text('Supplier grid');
  }
}
