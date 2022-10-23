import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:get/get.dart';
import 'dart:math';

part 'input_otp_widget.g.dart';

@swidget
Widget inputOTPWidget({required double otpCode, required Function() callback}) {
  RxList<NodeOTP> listNodeOTP = [
    NodeOTP(status: 1),
    NodeOTP(),
    NodeOTP(),
    NodeOTP(),
    NodeOTP(),
    NodeOTP(),
  ].obs;

  Rx<int> currentIndex = 0.obs;

  var focusNode = FocusNode();

  bool isChecking = false;

  int count = 0;

  void checkOTP() {
    double result = 0;
    for (var i = 0; i < listNodeOTP.length; i++) {
      result = result + int.parse(listNodeOTP[i].value) * (100000 / pow(10, i));
    }
    if (result == otpCode) {
      listNodeOTP.forEach((element) {
        element.status = 1;
      });
      callback();
    } else {
      listNodeOTP.forEach((element) {
        element.status = 3;
      });
      isChecking = false;
    }
    listNodeOTP.refresh();
  }

  void changeStatus(String value) {
    for (var i = 0; i < listNodeOTP.length; i++) {
      if (i < currentIndex.value) {
        listNodeOTP[i].status = 2;
      } else if (i > currentIndex.value) {
        listNodeOTP[i].status = 0;
      }
      listNodeOTP[currentIndex.value].status = 1;
      listNodeOTP.refresh();
    }
    if (listNodeOTP[listNodeOTP.length - 1].value != "") {
      isChecking = true;
      checkOTP();
    }
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child: Obx(
      () => GestureDetector(
        onTap: () {
          focusNode.requestFocus();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox.shrink(
              child: TextField(
                autofocus: true,
                focusNode: focusNode,
                onEditingComplete: null,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (!isChecking) {
                    if (value.characters.length < count) {
                      if (listNodeOTP[5].value != "") {
                        currentIndex.value = currentIndex.value + 1;
                      } else {
                        listNodeOTP[currentIndex.value].value = "";
                      }

                      if (currentIndex.value != 0) {
                        listNodeOTP[currentIndex.value - 1].value = "";
                        currentIndex.value = currentIndex.value - 1;
                      }
                      changeStatus(value);
                    } else {
                      if (listNodeOTP[5].value == "") {
                        listNodeOTP[currentIndex.value].value = value.characters.last.toString();
                      }
                      if (currentIndex.value != 5) {
                        currentIndex.value = currentIndex.value + 1;
                      }
                      changeStatus(value);
                    }
                    count = value.characters.length;
                  }
                },
              ),
            ),
            InputOTP(status: listNodeOTP[0].status, value: listNodeOTP[0].value),
            InputOTP(status: listNodeOTP[1].status, value: listNodeOTP[1].value),
            InputOTP(status: listNodeOTP[2].status, value: listNodeOTP[2].value),
            InputOTP(status: listNodeOTP[3].status, value: listNodeOTP[3].value),
            InputOTP(status: listNodeOTP[4].status, value: listNodeOTP[4].value),
            InputOTP(status: listNodeOTP[5].status, value: listNodeOTP[5].value),
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
                  : status == 2
                      ? ColorName.black000
                      : ColorName.redFf3,
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
