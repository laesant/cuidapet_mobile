import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifeCycle {
  @override
  void onInit(Map<String, dynamic>? params) {
    print('onInit called');
    super.onInit(params);
  }

  @override
  Future<void> onReady() async {
    await _hasRegisteredAddress();
    super.onReady();
  }

  Future<void> _hasRegisteredAddress() async {
   
  }
}
