part of '../home_page.dart';

class _HomeCategoriesWidget extends StatelessWidget {
  const _HomeCategoriesWidget({required this.controller});
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 130,
        child: Observer(
          builder: (_) {
            return Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.listCategories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final category = controller.listCategories[index];
                  return _CategoryItem(category, controller);
                },
              ),
            );
          },
        ));
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem(this.category, this._controller);
  final SupplierCategoryModel category;
  final HomeController _controller;
  static const categoriesIcons = {
    'P': Icons.pets,
    'V': Icons.local_hospital,
    'C': Icons.store_mall_directory,
  };
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _controller.filterSupplierCategory(category),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Observer(
              builder: (_) {
                return CircleAvatar(
                  radius: 30,
                  backgroundColor:
                      _controller.supplierCategoryFilterSelected?.id ==
                              category.id
                          ? context.colorScheme.tertiaryContainer
                          : context.primaryColorLight,
                  child: Icon(
                    size: 30,
                    categoriesIcons[category.type],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Text(category.name),
          ],
        ),
      ),
    );
  }
}
