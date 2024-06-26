import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends SliverAppBar {
  const HomeAppBar({super.key})
      : super(
          pinned: true,
          elevation: 0,
          expandedHeight: 100,
          collapsedHeight: 100,
          flexibleSpace: const _CuidapetAppBar(),
        );
}

class _CuidapetAppBar extends StatelessWidget {
  const _CuidapetAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
          onPressed: () {},
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
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
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