import 'package:flutter/material.dart';

import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_controller.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_detail.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_service_widget.dart';

class SupplierPage extends StatefulWidget {
  final int _supplierId;
  const SupplierPage({
    super.key,
    required int supplierId,
  }) : _supplierId = supplierId;
  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState
    extends PageLifeCycleState<SupplierController, SupplierPage> {
  late final ScrollController _scrollController;
  final ValueNotifier<bool> sliverCollapsed = ValueNotifier(false);
  @override
  Map<String, dynamic>? get params => {'supplierId': widget._supplierId};
  
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 180 &&
          !_scrollController.position.outOfRange) {
        sliverCollapsed.value = true;
      } else if (_scrollController.offset <= 180 &&
          !_scrollController.position.outOfRange) {
        sliverCollapsed.value = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.schedule),
        label: const Text('Fazer agendamento'),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          ValueListenableBuilder<bool>(
            valueListenable: sliverCollapsed,
            child: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.fadeTitle,
                StretchMode.zoomBackground,
              ],
              background: Image.network(
                'https://img.nsctotal.com.br/wp-content/uploads/2023/12/Golden-retriever.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            ),
            builder: (_, value, child) {
              return SliverAppBar(
                  pinned: true,
                  expandedHeight: 200,
                  leading: Visibility(
                      visible: value,
                      replacement: const CircleAvatar(
                        child: BackButton(),
                      ),
                      child: const BackButton()),
                  title: Visibility(
                    visible: value,
                    child: const Text('Clinica Central ABC'),
                  ),
                  flexibleSpace: child);
            },
          ),
          SliverToBoxAdapter(
            child: SupplierDetail(),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Serviços (0 selecionados)',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
          SliverList.builder(
            itemCount: 200,
            itemBuilder: (context, index) {
              return SupplierServiceWidget();
            },
          )
        ],
      ),
    );
  }
}
