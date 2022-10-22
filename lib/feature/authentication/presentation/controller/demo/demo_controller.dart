import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../../base/domain/base_observer.dart';
import '../../../domain/usecases/get_user_data_usecase.dart';

class DemoController extends GetxController {
  final GetDataUserUsecase _getDataUserUsecase;

  DemoController(this._getDataUserUsecase);

  RxString textApi = ''.obs;
  final formKey = GlobalKey<FormBuilderState>();
  final phomeTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  void onTap() {
    _getDataUserUsecase.execute(
      observer: Observer(
        onSuccess: (val) {
          if (kDebugMode) {
            print(val.toJson());
          }
          textApi.value = jsonEncode(val.toJson());
        },
        onError: (e) {
          print(e);
        },
      ),
    );
  }
}
