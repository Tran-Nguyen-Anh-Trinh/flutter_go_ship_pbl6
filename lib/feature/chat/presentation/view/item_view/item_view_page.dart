import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controller/item_view/item_view_controller.dart';

class ItemViewPage extends GetView<ItemViewController> {
    
    const ItemViewPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('ItemViewPage'),),
            body: Container(),
        );
    }
}