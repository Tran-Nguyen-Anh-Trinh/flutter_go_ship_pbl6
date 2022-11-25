import 'package:flutter_go_ship_pbl6/base/presentation/base_app_bar.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/controller/activate_customer/activate_customer_controller.dart';

class ActivateCustomerPage extends BaseWidget<ActivateCustomerController> {
  const ActivateCustomerPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: const Text('Hoạt động'),
        leading: null,
      ),
      body: Container(),
    );
  }
}
