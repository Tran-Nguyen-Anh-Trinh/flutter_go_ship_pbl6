import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/customer_info_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/shipper_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/update_customer_info_usecase.dart';
import 'package:flutter_go_ship_pbl6/utils/extension/form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../base/presentation/base_widget.dart';
import '../../../../../utils/config/app_config.dart';
import '../../../../../utils/services/Firebase/cloud_storage.dart';
import '../../../data/providers/remote/request/customer_request.dart';
import '../../../domain/usecases/update_shipper_info_usecase.dart';

class ProfileController extends BaseController {
  ProfileController(this._cloudStorage, this._updateCustomerInfoUsecase,
      this._updateShipperInfoUsecase);

  final UpdateCustomerInfoUsecase _updateCustomerInfoUsecase;
  final UpdateShipperInfoUsecase _updateShipperInfoUsecase;
  final CloudStorage _cloudStorage;
  final formKey = GlobalKey<FormBuilderState>();

  final phoneTextEditingController = TextEditingController();
  final nameTextEditingController = TextEditingController();
  String dropdownValue = '';

  final isLoading = false.obs;

  final List<String> items = ['Chọn giới tính', 'Nam', 'Nữ'];

  final _picker = ImagePicker();
  final imagePath = ''.obs;

  CustomerModel customerInfo = CustomerModel();
  ShipperModel shipperInfo = ShipperModel();
  AccountModel accountInfo = AccountModel();

  @override
  void onInit() {
    super.onInit();
    customerInfo = AppConfig.customerInfo;
    shipperInfo = AppConfig.shipperInfo;
    accountInfo = AppConfig.accountInfo;
    if (accountInfo.role == 1) {
      nameTextEditingController.text = customerInfo.name ?? '';
      final gender = customerInfo.gender ?? 0;
      dropdownValue = items[gender];
    } else {
      nameTextEditingController.text = shipperInfo.name ?? '';
      final gender = shipperInfo.gender ?? 0;
      dropdownValue = items[gender];
    }
    phoneTextEditingController.text = accountInfo.phoneNumber ?? '';
  }

  void onTapSave() async {
    try {
      final fbs = formKey.formBuilderState!;
      final name = FormFieldType.name.field(fbs);
      [
        name,
      ].validateFormFields();

      isLoading.value = true;
      List<String> imageLink = [];
      if (imagePath.value.isNotEmpty) {
        imageLink = await _cloudStorage.putAllFile([File(imagePath.value)]);
      }
      if (accountInfo.role == 1) {
        _updateCustomerInfoUsecase.execute(
          observer: Observer(
            onSuccess: (account) {
              isLoading.value = false;
              showOkDialog(message: "Cập nhật thông tin thành công")
                  .then((value) {
                if (value == OkCancelResult.ok) {
                  back();
                }
              });

              if (account != null) {
                AppConfig.customerInfo = account;
              }
            },
            onError: (e) async {
              if (e is DioError) {
                if (e.response != null) {
                  print(e.response);
                } else {
                  print(e.message);
                }
              }
              debugPrint(e.toString());
              isLoading.value = false;
              showOkDialog(message: "Opps! Có lỗi đã xảy ra");
            },
          ),
          input: CustomerRequest(
            name: nameTextEditingController.text.trim(),
            address: customerInfo.address,
            avatarUrl:
                imageLink.isNotEmpty ? imageLink.first : customerInfo.avatarUrl,
            birthDate: customerInfo.birthDate,
            distanceView: customerInfo.distanceView,
            gender: items.indexOf(dropdownValue),
          ),
        );
      } else {
        _updateShipperInfoUsecase.execute(
          observer: Observer(
            onSuccess: (account) {
              isLoading.value = false;
              showOkDialog(message: "Cập nhật thông tin thành công")
                  .then((value) {
                if (value == OkCancelResult.ok) {
                  back();
                }
              });

              if (account != null) {
                AppConfig.shipperInfo = account;
              }
            },
            onError: (e) async {
              if (e is DioError) {
                if (e.response != null) {
                  print(e.response);
                } else {
                  print(e.message);
                }
              }
              debugPrint(e.toString());
              isLoading.value = false;
              showOkDialog(message: "Opps! Có lỗi đã xảy ra");
            },
          ),
          input: ShipperRequest(
            avatarUrl:
                imageLink.isNotEmpty ? imageLink.first : shipperInfo.avatarUrl,
            distanceReceive: shipperInfo.distanceReceive,
          ),
        );
      }
    } on Exception catch (e) {
      isLoading.value = false;
      showOkDialog(message: "Opps! Có lỗi đã xảy ra");
    }
  }

  void getPhoto() async {
    try {
      final image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      imagePath.value = image!.path;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void onClose() {
    nameTextEditingController.dispose();
    phoneTextEditingController.dispose();
    super.onClose();
  }
}
