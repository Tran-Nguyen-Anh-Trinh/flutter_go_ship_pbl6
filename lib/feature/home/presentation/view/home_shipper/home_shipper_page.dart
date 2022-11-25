import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/home_shipper/home_shipper_controller.dart';

class HomeShipperPage extends BaseWidget<HomeShipperController> {
  const HomeShipperPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeShipperPage'),
      ),
      body: Container(),
    );
  }
}
