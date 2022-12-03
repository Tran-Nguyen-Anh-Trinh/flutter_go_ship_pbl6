import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/customer_info_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/update_customer_info_usecase.dart';
import 'package:flutter_go_ship_pbl6/utils/extension/form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../base/presentation/base_widget.dart';
import '../../../../../utils/config/app_config.dart';
import '../../../../../utils/services/Firebase/cloud_storage.dart';

class ProfileController extends BaseController {
  ProfileController(this._cloudStorage, this._updateCustomerInfoUsecase);

  final UpdateCustomerInfoUsecase _updateCustomerInfoUsecase;
  final CloudStorage _cloudStorage;
  final formKey = GlobalKey<FormBuilderState>();

  final phoneTextEditingController = TextEditingController();
  final nameTextEditingController = TextEditingController();
  String dropdownValue = '';

  final isLoading = false.obs;

  final List<String> items = ['Chọn giới tính', 'Nam', 'Nữ'];

  final _picker = ImagePicker();
  final imagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    phoneTextEditingController.text = AppConfig.accountModel.phoneNumber ?? '';
    nameTextEditingController.text = AppConfig.customerInfo.name ?? '';
    final gender = AppConfig.customerInfo.gender ?? 0;
    dropdownValue = items[gender];
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

      _updateCustomerInfoUsecase.execute(
        observer: Observer(
          onSuccess: (account) {
            isLoading.value = false;
            showOkDialog(message: "Cập nhật thông tin thành công");
          },
          onError: (e) async {
            debugPrint(e.toString());
            isLoading.value = false;
            showOkDialog(message: "Opps! Có lỗi đã xảy ra");
          },
        ),
        input: CustomerModel(
          name: nameTextEditingController.text.trim(),
          address: AppConfig.customerInfo.address,
          avatarUrl: imageLink.isNotEmpty
              ? imageLink.first
              : AppConfig.customerInfo.avatarUrl,
          birthDate: AppConfig.customerInfo.birthDate,
          distanceView: AppConfig.customerInfo.distanceView,
          gender: items.indexOf(dropdownValue),
        ),
      );
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
