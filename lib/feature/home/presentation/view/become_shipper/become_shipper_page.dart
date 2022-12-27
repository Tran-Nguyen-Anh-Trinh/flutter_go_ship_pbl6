import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_app_bar.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/become_shipper/become_shipper_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_route.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/extension/route_type.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BecomeShipperPage extends BaseWidget<BecomeShipperController> {
  const BecomeShipperPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: const Text('Lái xe cùng Go Ship'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: Text(
                'Go Ship',
                style: AppTextStyle.w800s33(ColorName.primaryColor),
              ),
            ),
          ),
          Center(
            child: Assets.images.goShipMoto.image(width: 100),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Trở thành đối tác của GoShip',
              style: AppTextStyle.w700s22(ColorName.black000),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Trở thành đối tác của GoShip để làm chủ cuộc sống của chính mình và hơn thế nữa. Hãy cùng nhau bắt đầu hành trình với chiếc xe của chính mình.',
              style: AppTextStyle.w500s17(ColorName.black000),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Dễ dàng và nhanh chóng tăng thêm thu nhập',
              style: AppTextStyle.w700s17(ColorName.black000),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Bắt đầu hành trình cùng\nGoship ngay nào!',
              style: AppTextStyle.w800s20(ColorName.black000),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
            child: CommonButton(
              onPressed: () {
                controller
                    .showOkCancelDialog(
                  title: 'Đăng ký trở thành Shipper',
                  message:
                      'Sau khi thực hiện đăng ký thành shipper bạn sẽ không thể tiếp tục sử dụng các chức năng hiện tại mà sẽ chuyển sang sử dụng các chức năng của shipper.\nBạn chắc chắn chứ??',
                  cancelText: 'Hủy',
                  okText: 'Tiếp tục',
                )
                    .then((value) {
                  if (value == OkCancelResult.ok) {
                    N.toConfirmShipper();
                  }
                });
              },
              child: Text(
                'Đăng ký',
                style: AppTextStyle.w600s17(ColorName.whiteFff),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
