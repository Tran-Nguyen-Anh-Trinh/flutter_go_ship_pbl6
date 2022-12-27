import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/camera_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/account_model.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/confirm_shipper_request.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/request/token_request%20.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/confirm_shipper_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/usecases/token_refresh_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/cloud_storage.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service_impl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan/scan.dart';
import '../../../../../utils/extension/form_builder.dart';

class ConfirmShipperController extends BaseController {
  ConfirmShipperController(
      this._storageService, this._cloudStorage, this._confirmShipperUsecase, this._refreshTokenUsecase);

  final StorageService _storageService;
  final CloudStorage _cloudStorage;
  final RefreshTokenUsecase _refreshTokenUsecase;

  final phoneTextEditingController = TextEditingController();
  final nameTextEditingController = TextEditingController();
  final noteTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final confirmState = BaseState();

  var isKeyBoardOn = false.obs;
  var addressNull = false.obs;

  String get _phone => phoneTextEditingController.text;
  String get _note => noteTextEditingController.text;
  String get _name => nameTextEditingController.text;

  final isDisableButton = true.obs;
  final ignoringPointer = false.obs;
  final errorMessage = ''.obs;
  final isShowPassword = true.obs;

  var shipper = ShipperModel().obs;

  var currentPageIndex = 1.obs;

  @override
  void onInit() {
    super.onInit();
    shipper.value = AppConfig.shipperInfo;
    print(shipper.value.toJson());
    phoneTextEditingController.text = AppConfig.accountInfo.phoneNumber ?? "";
    nameTextEditingController.text = shipper.value.name ?? "";
    noteTextEditingController.text = shipper.value.address?.addressNotes ?? "";
  }

  @override
  void onClose() {
    phoneTextEditingController.dispose();
    noteTextEditingController.dispose();
    nameTextEditingController.dispose();
    super.onClose();
  }

  // Page 1

  void hideErrorMessage() {
    errorMessage.value = '';
  }

  void updateLoginButtonState() {
    isDisableButton.value = _phone.isEmpty || _note.isEmpty || _name.isEmpty;
  }

  void onNextPage1(BuildContext context) {
    hideErrorMessage();
    try {
      if ((shipper.value.address?.latitude ?? "").isEmpty || (shipper.value.address?.longitude ?? "").isEmpty) {
        addressNull.value = true;
        isDisableButton.value = true;
      }
      final fbs = formKey.formBuilderState!;
      final phoneField = FormFieldType.phone.field(fbs);
      final noteField = FormFieldType.memo.field(fbs);
      final nameField = FormFieldType.name.field(fbs);
      [
        phoneField,
        noteField,
        nameField,
      ].validateFormFields();
      shipper.value.name = _name;
      shipper.value.address?.addressNotes = _note;

      if ((AppConfig.accountInfo.phoneNumber ?? "").isEmpty ||
          (shipper.value.name ?? "").isEmpty ||
          shipper.value.gender == 0 ||
          (shipper.value.address?.addressNotes ?? "").isEmpty) {
        _showToastMessage("Vui lòng điền đầy đủ thông tin");
        return;
      }

      if ((shipper.value.address?.latitude ?? "").isEmpty || (shipper.value.address?.longitude ?? "").isEmpty) {
        return;
      }
      if (confirmState.isLoading) return;
      [
        Permission.camera,
        Permission.storage,
      ].request().then((ignored) {
        for (var element in ignored.values) {
          element.isPermanentlyDenied ? openAppSettings() : null;
        }
        fetchPermissionCameraStatus();
      });
    } on Exception catch (e) {
      isDisableButton.value = true;
    }
  }

  void onTapAddAddress() {
    addressNull.value = false;
    [
      Permission.locationWhenInUse,
    ].request().then((ignored) {
      for (var element in ignored.values) {
        element.isPermanentlyDenied ? openAppSettings() : null;
      }
      fetchPermissionLocationStatus();
    });
  }

  void _showToastMessage(String message) {
    confirmState.onError(message);
    ignoringPointer.value = false;
    errorMessage.value = message;
  }

  void resetDataTextField() {
    hideErrorMessage();
    noteTextEditingController.text = '';
  }

  void fetchPermissionLocationStatus() {
    Permission.locationWhenInUse.status.then(
      (status) {
        if (status == PermissionStatus.granted) {
          N.toAddAddress(isSetting: false);
        }
      },
    );
  }

  void fetchPermissionCameraStatus() {
    Permission.camera.status.then(
      (value) {
        if (value == PermissionStatus.granted) {
          currentPageIndex.value = 2;
        }
      },
    );
  }

  // Page2 vs Page3

  XFile? frontCCCD;
  XFile? backSideCCCD;
  XFile? faceVideo;
  String? infoCCCD;

  void identifyCheck(TypeCamera typeCamera) async {
    N.toConfirmShipperCamera(typeCamera: typeCamera);
  }

  void confirmFrontCCCD(XFile xFile) async {
    String? result = await Scan.parse(xFile.path);
    if (result != null) {
      infoCCCD = result;
      frontCCCD = xFile;
      N.toConfirmShipperCamera(typeCamera: TypeCamera.backsideCCCD);
    } else {
      showOkDialog(
        message: "Hãy đặt căn cước công dân trên mặt phẳng và đảm bảo hình chụp không bị mờ, tối hoặc chói sáng",
        title: "Xác nhận không thành công",
      ).then((value) {
        N.toConfirmShipperCamera(typeCamera: TypeCamera.frontCCCD);
      });
    }
  }

  void confirmBackSideCCCD(XFile xFile) async {
    currentPageIndex.value = 3;
    backSideCCCD = xFile;
  }

  void confirmFace(XFile xFile) async {
    currentPageIndex.value = 4;
    faceVideo = xFile;
  }

  // confirm

  final ConfirmShipperUsecase _confirmShipperUsecase;
  List<String> urls = [];
  var stateConfirm = false.obs;

  void confirmShipper() async {
    stateConfirm.value = true;
    if (frontCCCD != null && backSideCCCD != null && faceVideo != null && infoCCCD != null) {
      if (urls.length != 3) {
        urls = await _cloudStorage.putAllxFile(
          [frontCCCD!, backSideCCCD!, faceVideo!],
        );
      }

      if (urls.length != 3) {
        confirmError();
        return;
      }
      print(ConfirmShipperRequest(
        shipper.value.name,
        shipper.value.gender,
        shipper.value.address,
        urls[0],
        urls[1],
        infoCCCD,
        urls[2],
      ).toJson());

      _confirmShipperUsecase.execute(
        observer: Observer(
          onSubscribe: () {},
          onSuccess: (_) {
            currentPageIndex.value = 5;
            stateConfirm.value = false;
          },
          onError: (e) async {
            if (e is DioError) {
              if (kDebugMode) {
                print(e);
                // print('================${e.response!.data["detail"].toString()}==================');
              }
              if (e.response!.statusCode == 403) {
                var account = AppConfig.accountInfo;
                await _refreshTokenUsecase.execute(
                  observer: Observer(
                    onSubscribe: () {},
                    onSuccess: (token) {
                      account.accessToken = token.access;
                      _storageService.setToken(account.toJson().toString());
                      AppConfig.accountInfo = account;
                      confirmShipper();
                    },
                    onError: (err) async {
                      print('================${err}==================');
                      if (err is DioError) {
                        if (err.response!.statusCode == 401) {
                          await showOkDialog(
                            title: "Phiên đăng nhập của bạn đã hết hạng",
                            message: "Vui lòng thực hiện đăng nhập lại!",
                          );
                          _storageService.removeToken();
                          AppConfig.accountInfo = AccountModel();
                          N.toWelcomePage();
                          N.toLoginPage();
                        } else {
                          confirmError();
                          return;
                        }
                      }
                    },
                  ),
                  input: TokenRequest(account.refreshToken, account.accessToken),
                );
              } else {
                confirmError();
                return;
              }
            }
          },
        ),
        input: ConfirmShipperRequest(
          shipper.value.name,
          shipper.value.gender,
          shipper.value.address,
          urls[0],
          urls[1],
          infoCCCD,
          urls[2],
        ),
      );
    }

    // ConfirmShipperRequest confirmShipperRequest;
  }

  void toLandingPage() {
    StorageServiceImpl().removeToken().then((value) {
      AppConfig.accountInfo = AccountModel();
      N.toWelcomePage();
    });
  }

  void confirmError() {
    showOkDialog(
      message:
          "Một số lỗi đã xảy ra trong quá trình xử lý\n vui lòng thử lại sau ít phút hoặc có thể thực hiện lại các bước!",
      title: "Xác thực không thành công",
    );
    stateConfirm.value = false;
  }
}
