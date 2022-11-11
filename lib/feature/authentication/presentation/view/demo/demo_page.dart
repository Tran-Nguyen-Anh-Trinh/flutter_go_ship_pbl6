import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/input_otp_widget.dart';
import 'package:flutter_go_ship_pbl6/utils/extension/form_builder.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../base/presentation/base_app_bar.dart';
import '../../controller/demo/demo_controller.dart';

class DemoPage extends GetWidget<DemoController> {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      // onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          title: const Text('Demo Page'),
          centerTitle: true,
          leading: null,
        ),
        body: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            FormBuilder(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  CommonTextField(
                    formKey: controller.formKey,
                    type: FormFieldType.phone,
                    controller: controller.phomeTextEditingController,
                    onTap: null,
                    onChanged: (_) {},
                  ),
                  CommonTextField(
                    formKey: controller.formKey,
                    type: FormFieldType.password,
                    controller: controller.passwordTextEditingController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    onTap: null,
                    onChanged: (_) {},
                    onSubmitted: (_) {},
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // InputOTPWidget(
                  //   callback: (otpCode) {
                  //     print('Thàng công');
                  //   },
                  // ),
                  CupertinoButton(
                    onPressed: controller.onTap,
                    child: const Text('Test API'),
                  ),
                  Obx(() => Text(controller.textApi.value)),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                  Positioned(
                    bottom: 15,
                    child: CupertinoButton(child: Assets.images.addIcon.image(scale: 3), onPressed: () {}),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.2, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.4, 0, size.width * 0.4, 20);
    path.arcToPoint(Offset(size.width * 0.6, 20), radius: const Radius.circular(10), clockwise: false);
    path.quadraticBezierTo(size.width * 0.6, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.8, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
