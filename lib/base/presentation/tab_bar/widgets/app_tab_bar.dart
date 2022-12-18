import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';

class AppTabBar extends StatelessWidget {
  final int selectedIndex;
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int> onItemSelected;

  const AppTabBar({
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  });

  Widget _buildItem(BottomNavigationBarItem item, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      height: kBottomNavigationBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: IconTheme(
              data: const IconThemeData(size: 24.0),
              child: isSelected ? item.activeIcon : item.icon,
            ),
          ),
          Flexible(
            child: Text(
              item.label!,
              style: isSelected
                  ? AppTextStyle.w400s11(ColorName.primaryColor, letterSpacing: 0.38)
                  : AppTextStyle.w400s11(ColorName.gray838, letterSpacing: 0.38),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map(
            (item) {
              final index = items.indexOf(item);
              return Expanded(
                child: CupertinoButton(
                  padding: const EdgeInsets.all(6),
                  onPressed: () => onItemSelected(index),
                  child: _buildItem(item, selectedIndex == index),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
