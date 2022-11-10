import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';

class WidgetToImage {
  late GlobalKey _containerKey;

  WidgetToImage() {
    _containerKey = GlobalKey();
  }

  Future<Uint8List> captureFromWidget(
    Widget widget, {
    Duration delay: const Duration(seconds: 1),
    double? pixelRatio,
    BuildContext? context,
    Size? targetSize,
  }) async {
    ui.Image? image = (await _widgetToUiImage(widget,
        delay: delay, pixelRatio: pixelRatio, context: context, targetSize: targetSize));

    final ByteData? byteData = await image?.toByteData(format: ui.ImageByteFormat.png);
    image?.dispose();

    return byteData!.buffer.asUint8List();
  }

  Future<ui.Image?> _widgetToUiImage(
    Widget widget, {
    Duration delay: const Duration(seconds: 1),
    double? pixelRatio,
    BuildContext? context,
    Size? targetSize,
  }) async {
    int retryCounter = 3;
    bool isDirty = false;

    Widget child = widget;

    if (context != null) {
      child = InheritedTheme.captureAll(
        context,
        MediaQuery(
            data: MediaQuery.of(context),
            child: Material(
              child: child,
              color: Colors.transparent,
            )),
      );
    }

    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

    Size logicalSize = targetSize ?? ui.window.physicalSize / ui.window.devicePixelRatio;
    Size imageSize = targetSize ?? ui.window.physicalSize;

    assert(logicalSize.aspectRatio.toStringAsPrecision(5) == imageSize.aspectRatio.toStringAsPrecision(5));

    final RenderView renderView = RenderView(
      window: ui.window,
      child: RenderPositionedBox(alignment: Alignment.center, child: repaintBoundary),
      configuration: ViewConfiguration(
        size: logicalSize,
        devicePixelRatio: pixelRatio ?? 1.0,
      ),
    );

    final PipelineOwner pipelineOwner = PipelineOwner();
    final BuildOwner buildOwner = BuildOwner(
        focusManager: FocusManager(),
        onBuildScheduled: () {
          isDirty = true;
        });

    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    final RenderObjectToWidgetElement<RenderBox> rootElement = RenderObjectToWidgetAdapter<RenderBox>(
        container: repaintBoundary,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: child,
        )).attachToRenderTree(
      buildOwner,
    );
    buildOwner.buildScope(
      rootElement,
    );
    buildOwner.finalizeTree();

    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();

    ui.Image? image;

    do {
      isDirty = false;
      image = (await repaintBoundary.toImage(pixelRatio: pixelRatio ?? (imageSize.width / logicalSize.width)));
      await Future.delayed(delay);
      if (isDirty) {
        buildOwner.buildScope(
          rootElement,
        );
        buildOwner.finalizeTree();
        pipelineOwner.flushLayout();
        pipelineOwner.flushCompositingBits();
        pipelineOwner.flushPaint();
      }
      retryCounter--;
    } while (isDirty && retryCounter >= 0);

    return image;
  }
}

class Screenshot<T> extends StatefulWidget {
  final Widget? child;
  final WidgetToImage controller;

  const Screenshot({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key);

  @override
  State<Screenshot> createState() {
    return ScreenshotState();
  }
}

class ScreenshotState extends State<Screenshot> with TickerProviderStateMixin {
  late WidgetToImage _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _controller._containerKey,
      child: widget.child,
    );
  }
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
