import 'package:flutter_go_ship_pbl6/base/presentation/base_app_bar.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/notification/notification_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/view/notification/widgets/widget.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';

class NotificationPage extends BaseWidget<NotificationController> {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: BaseAppBar(
          title: const Text('Thông báo'),
        ),
        backgroundColor: ColorName.whiteFff,
        body: ListView.builder(
          itemCount: AppConfig.listNotification.length,
          itemBuilder: (context, index) {
            return NotificationWidget(
              notification: AppConfig.listNotification[index],
              topBorder: index == 0 ? true : false,
              onPressed: () {
                controller.toDetail(AppConfig.listNotification[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
