part of '../home_page.dart';

class _HomeCategoriesWidget extends StatelessWidget {
  const _HomeCategoriesWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        itemCount: 15,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const _CategoryItem();
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(
              Icons.pets,
              size: 30,
            ),
          ),
          SizedBox(height: 8),
          Text('Petshop'),
        ],
      ),
    );
  }
}
