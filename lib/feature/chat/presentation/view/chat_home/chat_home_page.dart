import 'package:flutter/cupertino.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_app_bar.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/chat/presentation/view/chat_home/empty_page/empty_page.dart';
import 'package:flutter_go_ship_pbl6/feature/chat/presentation/view/chat_home/widgets/user_item.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_config.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/services/Models/infor_user.dart';
import '../../controller/home_chat/chat_home_controller.dart';

class ChatHomePage extends GetView<ChatHomeController> {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BaseAppBar(
        title: const Text(
          'Trò chuyện',
        ),
      ),
      floatingActionButton: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Assets.images.adminIcon.image(scale: 3),
        onPressed: () {
          N.toChatDetail(
            input: InforUser(phone: '0343440209', name: 'Admin'),
          );
        },
      ),
      body: controller.chatHomeState.widget(
        onEmpty: const LoadingWidget(),
        onSuccess: (_) {
          return controller.userList.isEmpty
              ? const EmptyPage()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Obx(
                    () => ListView.builder(
                      itemCount: controller.userList.length,
                      itemBuilder: ((context, index) {
                        return UserItem(
                          inforUser: controller.userList[index].inforUser,
                          messages: controller.userList[index].messages,
                          sender: controller.userList[index].sender,
                          isNew: controller.userList[index].isNew,
                          onPressed: () {
                            controller.setNewMessages(
                                'messages/${AppConfig.accountModel.phoneNumber}/${controller.userList[index].inforUser.phone}/isNew');
                            N.toChatDetail(
                              input: controller.userList[index].inforUser,
                            );
                          },
                        );
                      }),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
