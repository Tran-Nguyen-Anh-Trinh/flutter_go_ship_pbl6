import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/feature/activate/presentation/view/order_detail/order_detail_bindings.dart';
import 'package:flutter_go_ship_pbl6/feature/home/data/models/order_model.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_orders_usecase.dart';
import 'package:flutter_go_ship_pbl6/feature/home/domain/usecases/get_orders_with_status_usecase.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ActivateShipperController extends BaseController {
  ActivateShipperController(this._getOrdersUsecase, this._getOrderWithStatusUsecase);

  final GetOrdersUsecase _getOrdersUsecase;
  final GetOrderWithStatusUsecase _getOrderWithStatusUsecase;

  var listOrder = List<OrderModel>.empty().obs;
  var listOrderWithStatus = List<OrderModel>.empty().obs;

  var isLoading = false.obs;

  var isLoadingOrderWithStatus = false.obs;

  final PageController pageController = PageController();

  ScrollController mainScrollController = ScrollController();
  ScrollController menuScrollController = ScrollController();
  ScrollController orderWithStatusScrollController = ScrollController();

  final refreshController = RefreshController(initialRefresh: false);

  var currentIndexPageView = 0.obs;

  var currentPage = 0.obs;
  var totalPage = 1;
  final maxOrder = 100000;

  var totalWithStatus = 0;
  var currentPageWithStatus = 0.obs;

  List<MenuItem> menu = [
    MenuItem("Tất cả", 0),
    MenuItem("Đơn hàng vừa nhận", 2),
    MenuItem("Đơn hàng đang giao", 3),
    MenuItem("Đã giao hàng thành công", 5),
    MenuItem("Đã bị hủy", 4),
  ];

  @override
  void onInit() {
    super.onInit();
    loadData();
    listenScrollController();
  }

  void onRefresh() async {
    currentPage.value = 1;
    listOrder.clear();
    isLoading.value = true;
    _getOrdersUsecase.execute(
      observer: Observer(
        onSuccess: (result) async {
          var orders = result.orders?.map((order) => OrderModel.fromJson(order)).toList() ?? [];
          totalPage = result.numPages ?? 1;
          listOrder.addAll(orders);
          refreshController.refreshCompleted();
          isLoading.value = false;
        },
        onError: (e) {
          isLoading.value = false;
          if (e is DioError) {
            if (kDebugMode) {
              if (e.response != null) {
                print(e.response?.data['detail'].toString());
              } else {
                print(e.message);
              }
            }
          }
        },
      ),
      input: currentPage.value,
    );
  }

  void loadData() {
    if (isLoading.value) {
      return;
    }
    currentPage.value += 1;
    if (currentPage.value > totalPage) {
      isLoading.value = false;
      return;
    }
    isLoading.value = true;
    _getOrdersUsecase.execute(
      observer: Observer(
        onSuccess: (result) async {
          var orders = result.orders?.map((order) => OrderModel.fromJson(order)).toList() ?? [];
          totalPage = result.numPages ?? 1;
          listOrder.addAll(orders);
          await Future.delayed(const Duration(seconds: 2));
          isLoading.value = false;
          if (mainScrollController.position.maxScrollExtent < mainScrollController.position.pixels + 100) {
            loadData();
          }
        },
        onError: (e) {
          if (e is DioError) {
            if (kDebugMode) {
              if (e.response != null) {
                print(e.response?.data['detail'].toString());
              } else {
                print(e.message);
              }
            }
          }
        },
      ),
      input: currentPage.value,
    );
  }

  void listenScrollController() {
    mainScrollController.addListener(() {
      if (mainScrollController.position.maxScrollExtent < mainScrollController.position.pixels + 100) {
        loadData();
      }
    });
    orderWithStatusScrollController.addListener(() {
      if (orderWithStatusScrollController.position.maxScrollExtent <
          orderWithStatusScrollController.position.pixels + 100) {
        loadListOrderStatus();
      }
    });
  }

  void selectPage(int index) {
    if (currentIndexPageView.value == 0 && index == 0) {
      onRefresh();
      return;
    }
    pageController.jumpToPage(
      index,
    );

    if (index < 2) {
      menuScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (index > menu.length - 2) {
      menuScrollController.animateTo(
        menuScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    totalWithStatus = maxOrder;
    currentPageWithStatus.value = 0;
    listOrderWithStatus.clear();
    loadListOrderStatus();
  }

  void swipePage(int index) {
    currentIndexPageView.value = index;
    if (index < 2) {
      menuScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (index > menu.length - 3) {
      menuScrollController.animateTo(
        menuScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    totalWithStatus = maxOrder;
    currentPageWithStatus.value = 0;
    listOrderWithStatus.clear();
    loadListOrderStatus();
  }

  void loadListOrderStatus() {
    if (isLoadingOrderWithStatus.value) {
      return;
    }
    currentPageWithStatus.value += 1;
    if (listOrderWithStatus.length >= totalWithStatus) {
      isLoadingOrderWithStatus.value = false;
      return;
    }
    isLoadingOrderWithStatus.value = true;
    _getOrderWithStatusUsecase.execute(
      observer: Observer(
        onSuccess: (result) async {
          var orders = result.orders?.map((order) => OrderModel.fromJson(order)).toList() ?? [];
          totalWithStatus = result.total ?? 1;
          listOrderWithStatus.addAll(orders);
          if (listOrderWithStatus.length >= totalWithStatus) {
            isLoadingOrderWithStatus.value = false;
          } else {
            await Future.delayed(const Duration(seconds: 2));
            isLoadingOrderWithStatus.value = false;
            if (orderWithStatusScrollController.position.maxScrollExtent <
                orderWithStatusScrollController.position.pixels + 100) {
              loadListOrderStatus();
            }
          }
        },
        onError: (e) {
          if (e is DioError) {
            if (kDebugMode) {
              if (e.response != null) {
                print(e.response?.data['detail'].toString());
              } else {
                print(e.message);
              }
            }
          }
        },
      ),
      input: GetOrderWithStatusRequest(
        page: currentPageWithStatus.value,
        statusId: menu[currentIndexPageView.value].status,
      ),
    );
  }

  void toDetail(OrderModel orderModel) {
    N.toOrderDetail(
      orderDetailInput: OrderDetailInput(
        "${orderModel.id}",
        "${0}",
        isRealtimeNotification: false,
        typeOrderDetail: TypeOrderDetail.shipper,
      ),
    );
  }
}

class MenuItem {
  String title;
  int status;
  MenuItem(this.title, this.status);
}
