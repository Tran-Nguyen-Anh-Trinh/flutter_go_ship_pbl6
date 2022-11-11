import 'package:flutter/material.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:get/get.dart';
import 'dart:math';

part 'input_otp_widget.g.dart';

@swidget
Widget inputOTPWidget({required Function(String otp) callback}) {
  RxList<NodeOTP> listNodeOTP = [
    NodeOTP(status: 1),
    NodeOTP(),
    NodeOTP(),
    NodeOTP(),
    NodeOTP(),
    NodeOTP(),
  ].obs;

  var focusNode = FocusNode();
  var textEditingController = TextEditingController();

  void changeStatus(String value) {
    int length = value.length;
    for (var i = 0; i < listNodeOTP.length; i++) {
      if (i > length - 1) {
        listNodeOTP[i].value = "";
      } else {
        listNodeOTP[i].value = value.characters.toList()[i];
      }
    }

    for (var i = 0; i < listNodeOTP.length; i++) {
      if (i < length) {
        listNodeOTP[i].status = 2;
      } else if (i > length - 2) {
        listNodeOTP[i].status = 0;
      }
      if (length < 6) {
        listNodeOTP[length].status = 1;
      }

      listNodeOTP.refresh();
    }
    if (length == 6) {
      callback(value);
    }
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    height: 60,
    child: Obx(
      () => GestureDetector(
        onTap: () {
          focusNode.requestFocus();
        },
        child: Stack(
          children: [
            Opacity(
              opacity: 0,
              child: TextField(
                controller: textEditingController,
                autofocus: true,
                focusNode: focusNode,
                onEditingComplete: () {},
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) {
                  changeStatus(value);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InputOTP(status: listNodeOTP[0].status, value: listNodeOTP[0].value),
                InputOTP(status: listNodeOTP[1].status, value: listNodeOTP[1].value),
                InputOTP(status: listNodeOTP[2].status, value: listNodeOTP[2].value),
                InputOTP(status: listNodeOTP[3].status, value: listNodeOTP[3].value),
                InputOTP(status: listNodeOTP[4].status, value: listNodeOTP[4].value),
                InputOTP(status: listNodeOTP[5].status, value: listNodeOTP[5].value),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class InputOTP extends StatelessWidget {
  InputOTP({
    this.status = 0,
    required this.value,
  });

  int status;
  String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: status == 1 ? ColorName.whiteFff : ColorName.whiteFaf,
        border: Border.all(
          color: status == 1
              ? ColorName.blue007
              : status == 0
                  ? ColorName.gray838
                  : ColorName.black000,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: ColorName.black000.withOpacity(0.25),
            offset: const Offset(2, 4),
          )
        ],
      ),
      height: 50,
      width: 40,
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: AppTextStyle.w400s15(Colors.black),
      ),
    );
  }
}

class NodeOTP {
  NodeOTP({this.status = 0, this.value = ""});

  int status;
  String value;
}
