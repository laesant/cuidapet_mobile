import 'package:cuidapet_mobile/app/core/helpers/debouncer.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends SliverAppBar {
  HomeAppBar({super.key, required HomeController controller})
      : super(
          pinned: true,
          elevation: 0,
          expandedHeight: 100,
          collapsedHeight: 100,
          flexibleSpace: _CuidapetAppBar(
            controller: controller,
          ),
        );
}

class _CuidapetAppBar extends StatelessWidget {
  _CuidapetAppBar({required this.controller});
  final HomeController controller;
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      scrolledUnderElevation: 0,
      title: const Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: Text(
          'Cuidapet',
          style: TextStyle(color: Colors.white),
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => controller.goToAddressPage(),
          icon: const Icon(Icons.location_on),
        ),
      ],
      flexibleSpace: Stack(
        children: [
          Container(
            height: 105.h,
            color: Theme.of(context).primaryColor,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: .9.sw,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(30),
                child: TextFormField(
                  onChanged: (value) {
                    _debouncer.run(() {
                      controller.filterSupplierByName(value);
                    });
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Pesquisar',
                      suffixIcon: const Icon(Icons.search, size: 25),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
