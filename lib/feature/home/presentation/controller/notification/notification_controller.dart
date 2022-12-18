import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/view/order_detail/order_detail_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/notification_model.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';

class NotificationController extends BaseController {
  void toDetail(NotificationModel notification) {
    if (notification.data?.type == 1 || notification.data?.type == 6) {
      N.toOrderDetail(
        orderDetailInput: OrderDetailInput(
          "${notification.data?.orderID}",
          "${notification.data?.time}",
          isRealtimeNotification: false,
          typeOrderDetail: TypeOrderDetail.shipper,
        ),
      );
    } else if (notification.data?.type == 5) {
      N.toOrderDetail(
        orderDetailInput: OrderDetailInput(
          "${notification.data?.orderID}",
          "${notification.data?.time}",
          isRealtimeNotification: false,
          typeOrderDetail: TypeOrderDetail.customerRating,
        ),
      );
    } else {
      N.toOrderDetail(
        orderDetailInput: OrderDetailInput(
          "${notification.data?.orderID}",
          "${notification.data?.time}",
          isRealtimeNotification: false,
          typeOrderDetail: TypeOrderDetail.customer,
        ),
      );
    }
  }
}
