import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';

import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/view/rating_shipper/rating_shipper_page.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/shipper_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/providers/remote/request/receive_order_request.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_rate_order_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/rate_order_usecase.dart';

class RatingShipperController extends BaseController<RateInput> {
  RatingShipperController(this._rateOrderUsecase, this._getRateOrderUsecase);

  final RateOrderUsecase _rateOrderUsecase;
  final GetRateOrderUsecase _getRateOrderUsecase;
  var shipperInfo = ShipperModel().obs;

  TextEditingController noteTextEditingController = TextEditingController();

  var rate = 5.obs;

  var rateInput = RateInput(0, ShipperModel()).obs;

  var isLoading = false.obs;

  var isViewOnly = false.obs;

  @override
  void onInit() {
    super.onInit();
    rateInput.value = input;
    if (input.shipperView) {
      shipperInfo.value = ShipperModel(
        name: input.customerModel?.name,
        phoneNumber: input.customerModel?.account?.phoneNumber,
        avatarUrl: input.customerModel?.avatarUrl,
      );
    } else {
      shipperInfo.value = input.shipperModel;
    }
    isLoading.value = true;
    _getRateOrderUsecase.execute(
      observer: Observer(
        onSuccess: (rateDetail) {
          try {
            rate.value = rateDetail.rate!;
            noteTextEditingController.text = rateDetail.feedback!;
            isViewOnly.value = true;
          } catch (e) {
            rate.value = 5;
          }
          isLoading.value = false;
        },
        onError: (_) {
          if (input.shipperView) {
            rate.value = 5;
            noteTextEditingController.text = "Hiện tại bạn chưa nhận được đánh giá từ khách hàng!";
            isViewOnly.value = true;
          }
          isLoading.value = false;
        },
      ),
      input: input.orderID,
    );
  }

  void ratingShipper() {
    isLoading.value = true;

    _rateOrderUsecase.execute(
      observer: Observer(
        onSuccess: (_) async {
          isLoading.value = false;
          await showOkDialog(title: "Hoàn thành đánh giá", message: "Cảm ơn bạn đã để lại đánh giá cho đơn hàng này!");
          back();
        },
        onError: (error) async {
          await showOkDialog(title: "Đánh giá thất bại", message: "Opps. Bạn có thể thử lại sau!");
          isLoading.value = false;
          back();
          if (error is DioError) {
            if (error.response != null) {
              print(error.response?.data['detail'].toString());
            } else {
              print(error.message);
            }
          }
        },
      ),
      input: RateOrderRequest(input.orderID, noteTextEditingController.text.trim(), rate.value),
    );
  }
}
