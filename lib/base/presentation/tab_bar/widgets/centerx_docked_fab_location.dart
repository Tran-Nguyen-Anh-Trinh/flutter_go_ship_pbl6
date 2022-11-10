import 'dart:math';

import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';


class CenterXDockedFabLocation extends StandardFabLocation with FabCenterOffsetX {
  const CenterXDockedFabLocation();

  @override
  String toString() => 'FloatingActionButtonLocation.centerDocked';

  @override
  double getOffsetY(ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    final double contentBottom = scaffoldGeometry.contentBottom;
    final double contentMargin = scaffoldGeometry.scaffoldSize.height - contentBottom;
    final double bottomViewPadding = scaffoldGeometry.minViewPadding.bottom;
    final double bottomSheetHeight = scaffoldGeometry.bottomSheetSize.height;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    final double snackBarHeight = scaffoldGeometry.snackBarSize.height;
    final double bottomMinInset = scaffoldGeometry.minInsets.bottom;
    final double safeMargin;

    if (contentMargin > bottomMinInset + fabHeight / 2.0) {
      // If contentMargin is higher than bottomMinInset enough to display the
      // FAB without clipping, don't provide a margin
      safeMargin = 0.0;
    } else if (bottomMinInset == 0.0) {
      // If bottomMinInset is zero(the software keyboard is not on the screen)
      // provide bottomViewPadding as margin
      safeMargin = bottomViewPadding;
    } else {
      // Provide a margin that would shift the FAB enough so that it stays away
      // from the keyboard
      safeMargin = fabHeight / 2.0 + kFloatingActionButtonMargin;
    }

    double fabY = contentBottom - fabHeight / 2.87 - safeMargin;
    // The FAB should sit with a margin between it and the snack bar.
    if (snackBarHeight > 0.0) {
      fabY = min(fabY, contentBottom - snackBarHeight - fabHeight - kFloatingActionButtonMargin);
    }
    // The FAB should sit with its center in front of the top of the bottom sheet.
    if (bottomSheetHeight > 0.0) {
      fabY = min(fabY, contentBottom - bottomSheetHeight - fabHeight / 2.0);
    }
    final double maxFabY = scaffoldGeometry.scaffoldSize.height - fabHeight - safeMargin;
    return min(maxFabY, fabY);
  }
}

extension FloatingActionButtonLocationExtension on FloatingActionButtonLocation {
  static const FloatingActionButtonLocation centerXDocked = CenterXDockedFabLocation();
}
