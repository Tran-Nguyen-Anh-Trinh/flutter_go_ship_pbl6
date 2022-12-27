import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/rate_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_shipper_rates_with_id_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_shipper_with_id_usecase.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:get/get.dart';

class ShipperDetailController extends BaseController<String> {
  ShipperDetailController(this._getShipperInfoWithIdUsecase, this._getShipperRatesWithIdUsecase);

  final GetShipperInfoWithIdUsecase _getShipperInfoWithIdUsecase;
  final GetShipperRatesWithIdUsecase _getShipperRatesWithIdUsecase;

  var loadingState = false.obs;
  var shipperInfo = ShipperModel().obs;
  var rateMean = 1.0.obs;
  RxList<RateModel> rates = List<RateModel>.empty().obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    loadingState.value = true;
    _getShipperInfoWithIdUsecase.execute(
      observer: Observer(
        onSuccess: (shipper) {
          shipperInfo.value = shipper;
          _getShipperRatesWithIdUsecase.execute(
            observer: Observer(
              onSuccess: (listRate) {
                loadingState.value = false;
                rateMean.value = listRate.mean ?? 1;
                for (var rate in listRate.rates ?? []) {
                  rates.add(RateModel.fromJson(rate));
                }
              },
              onError: (e) async {
                print(e);
                await showOkDialog(title: 'Go Ship', message: 'Máy chủ không phản hồi vui lòng thử lại sau');
                back();
              },
            ),
            input: int.parse(input),
          );
          print(shipper.toJson());
        },
        onError: (e) async {
          print(e);
          await showOkDialog(title: 'Go Ship', message: 'Máy chủ không phản hồi vui lòng thử lại sau');
          back();
        },
      ),
      input: int.parse(input),
    );
  }

  void createOrder() {
    if (shipperInfo.value.phoneNumber != null) {
      N.toCreateOrder(shipperID: shipperInfo.value.phoneNumber);
    } else {
      showOkDialog(title: 'Go Ship', message: 'Không thể tạo đơn hàng ngay lúc này');
    }
  }
}
