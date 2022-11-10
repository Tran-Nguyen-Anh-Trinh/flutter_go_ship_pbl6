import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/home_shipper/home_shipper_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeShipperPage extends GetView<HomeShipperController> {
  const HomeShipperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeShipperPage'),
      ),
      body: Container(),
    );
  }
}
