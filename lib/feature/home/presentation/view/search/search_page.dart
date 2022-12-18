import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/feature/home/presentation/controller/search/search_controller.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';

class SearchPage extends BaseWidget<SearchController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
                child: CommonSearchBar(
                  leftPadding: 10,
                  rightPadding: 5,
                  leadingPressed: controller.backToHome,
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    child: Assets.images.backIcon.image(width: 10, color: ColorName.primaryColor),
                  ),
                  trailingPressed: controller.searchPlace,
                  trailing: Container(
                    padding: const EdgeInsets.all(10),
                    child: Assets.images.searchIcon.image(height: 25, width: 25),
                  ),
                  title: SizedBox(
                    child: TextField(
                      onSubmitted: (value) {
                        controller.searchPlace();
                      },
                      controller: controller.searchTextEditingController,
                      autofocus: true,
                      style: AppTextStyle.w400s14(ColorName.black000),
                      showCursor: true,
                      cursorColor: ColorName.primaryColor,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: "",
                        hintText: "Tìm kiếm ở đây",
                      ),
                      onChanged: (value) => controller.textChangeListener(value),
                    ),
                  ),
                ),
              ),
              if (!controller.searchState.value)
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10, bottom: 15),
                  child: Text(
                    controller.isSearching.value ? 'Kết quả tìm kiếm' : 'Gần đây',
                    textAlign: TextAlign.left,
                    style: AppTextStyle.w600s16(ColorName.black000),
                  ),
                ),
              if (!controller.searchState.value && controller.historys.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => controller.isSearching.value
                            ? controller.goToPlace(index)
                            : controller.serachWithHistory(index),
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 0.5, color: ColorName.gray828),
                            ),
                          ),
                          child: controller.isSearching.value
                              ? commonSearchItem(
                                  controller.listPosition[index].name,
                                  Assets.images.searchPlaceIcon.image(height: 24, width: 24),
                                )
                              : commonSearchItem(
                                  controller.historys[index],
                                  Assets.images.historyIcon.image(height: 24, width: 24),
                                ),
                        ),
                      );
                    },
                    itemCount:
                        controller.isSearching.value ? controller.listPosition.length : controller.historys.length,
                  ),
                ),
              if (controller.historys.isEmpty && !controller.searchState.value)
                Expanded(
                  child: Center(
                    child: Assets.images.emptyHistory.image(width: 250),
                  ),
                ),
              if (controller.historys.isEmpty && !controller.searchState.value)
                const Expanded(
                  child: SizedBox(height: 100),
                ),
              if (controller.searchState.value)
                const Expanded(
                  child: LoadingWidget(
                    color: ColorName.primaryColor,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

Widget commonSearchItem(
  String title,
  Widget leading,
) {
  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        leading,
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            overflow: TextOverflow.ellipsis,
            title,
            style: AppTextStyle.w400s14(ColorName.black333, letterSpacing: 0.38),
          ),
        ),
      ],
    ),
  );
}
