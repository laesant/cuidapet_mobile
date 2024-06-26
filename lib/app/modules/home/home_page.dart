import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';

import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:cuidapet_mobile/app/modules/home/widgets/home_app_bar.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageLifeCycleState<HomeController, HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => const [
          HomeAppBar(),
        ],
        body: Container(),
      ),
    );
  }
}
