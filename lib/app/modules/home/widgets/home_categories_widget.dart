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
                  return _CategoryItem(category);
                },
              ),
            );
          },
        ));
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem(this.category);
  final SupplierCategoryModel category;
  static const categoriesIcons = {
    'P': Icons.pets,
    'V': Icons.local_hospital,
    'C': Icons.store_mall_directory,
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(
              categoriesIcons[category.type],
              size: 30,
            ),
          ),
          const SizedBox(height: 10),
          Text(category.name),
        ],
      ),
    );
  }
}
