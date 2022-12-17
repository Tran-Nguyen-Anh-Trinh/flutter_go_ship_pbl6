import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/view/order_detail_shipper/order_detail_shipper_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/notification_model.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';

class NotificationController extends BaseController {
  void toDetail(NotificationModel notification) {
    if (notification.data?.type == 1) {
      N.toOrderDetailShipper(
        orderDetailInput: OrderDetailShipperInput(
          "${notification.data?.orderID}",
          "${notification.data?.time}",
          isRealtimeNotification: false,
        ),
      );
    }
  }
}
