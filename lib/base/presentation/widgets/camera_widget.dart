import 'dart:async';
import 'dart:ffi';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/blur_widget.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';

// return Scaffold(
//   backgroundColor: Colors.white,
//   body: Center(
//     child: Obx(
//       () => controller.cameras.isNotEmpty
//           ? CameraWidget(
//               cameras: controller.cameras,
//               style: TypeCamera.face,
//               result: ((xFile) {
//                 print("=========================${xFile.path}=================");
//               }),
//             )
//           : Container(
//               color: Colors.black,
//             ),
//     ),
//   ),
// );

//     RxList<CameraDescription> cameras = List<CameraDescription>.empty().obs;
// @override
// Future<void> onInit() async {
//   super.onInit();
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras.value = await availableCameras();
// }

enum TypeCamera {
  frontCCCD,
  backsideCCCD,
  face,
}

class CameraWidget extends StatefulWidget {
  CameraWidget({Key? key, required this.cameras, required this.style, required this.result}) : super(key: key);

  List<CameraDescription> cameras;
  TypeCamera style;
  Function(XFile xFile) result;
  String? faceTitle;

  @override
  State<CameraWidget> createState() {
    return _CameraWidgetState();
  }
}

class _CameraWidgetState extends State<CameraWidget> with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    if (widget.style == TypeCamera.frontCCCD || widget.style == TypeCamera.backsideCCCD) {
      onNewCameraSelected(widget.cameras.first);
    } else if (widget.style == TypeCamera.face) {
      try {
        onNewCameraSelected(widget.cameras[1]);
      } catch (_) {
        onNewCameraSelected(widget.cameras.last);
      }
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
            child: Container(
              color: Colors.black,
              child: _cameraPreviewWidget(),
            ),
          ),
          _viewBlur(),
        ],
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const SizedBox.shrink();
    } else {
      return CameraPreview(
        controller!,
      );
    }
  }

  Widget _viewBlur() {
    if (widget.style == TypeCamera.frontCCCD) {
      return camreaCCCD("CHỤP MẶT TRƯỚC");
    }
    if (widget.style == TypeCamera.backsideCCCD) {
      return camreaCCCD("CHỤP MẶT SAU");
    }
    if (widget.style == TypeCamera.face) {
      return cameraFace();
    }
    return const SizedBox.shrink();
  }

  Widget camreaCCCD(String title) {
    final CameraController? cameraController = controller;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double widthCCCD = widthScreen - 25;
    double heightCCCD = widthScreen - 125;
    return BlurWidget(
      positionIgnoreBlur: PositionIgnoreBlur(
        width: widthCCCD,
        height: heightCCCD,
        x: widthScreen / 2,
        y: heightScreen / 2,
      ),
      childInsideIgnoreBlur: Center(
        child: Assets.images.frameCccd.image(width: widthCCCD - 50, height: heightCCCD - 50),
      ),
      boderRadius: 15,
      child: Padding(
        padding: EdgeInsets.only(
          top: heightScreen / 4.5,
          left: 27,
          right: 27,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              title,
              style: AppTextStyle.w600s16(ColorName.whiteFff),
            ),
            const SizedBox(height: 10),
            Text(
              'Hãy đặt căn cước công dân trên mặt phẳng và đảm bảo hình chụp không bị mờ, tối hoặc chói sáng',
              style: AppTextStyle.w400s12(ColorName.whiteFff),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: heightScreen * 0.55),
            if (cameraController != null &&
                !cameraController.value.isRecordingVideo &&
                !cameraController.value.isTakingPicture)
              SizedBox(
                height: 80,
                width: 80,
                child: IconButton(
                  icon: Assets.images.takePhotoIcon.image(width: 80, height: 80),
                  onPressed: cameraController != null &&
                          cameraController.value.isInitialized &&
                          !cameraController.value.isRecordingVideo &&
                          !cameraController.value.isTakingPicture
                      ? onTakePictureButtonPressed
                      : null,
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget cameraFace() {
    final CameraController? cameraController = controller;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return BlurWidget(
      positionIgnoreBlur: PositionIgnoreBlur(
        width: widthScreen * 0.75,
        height: widthScreen * 0.75,
        x: widthScreen / 2,
        y: heightScreen / 2,
      ),
      childInsideIgnoreBlur: Transform.scale(
        scale: 1.5,
        child: Center(
          child: AspectRatio(
            aspectRatio: 1 / 1.5,
            child: _cameraPreviewWidget(),
          ),
        ),
      ),
      boderRadius: widthScreen * 0.75,
      blurOpacity: 0.8,
      child: Padding(
        padding: EdgeInsets.only(
          top: heightScreen / 4.5,
          left: 27,
          right: 27,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'XÁC NHẬN KHUÔN MẶT',
              style: AppTextStyle.w600s16(ColorName.whiteFff),
            ),
            const SizedBox(height: 10),
            Text(
              'Giữ khuôn mặt nằm thẳng trong khung hình',
              style: AppTextStyle.w400s12(ColorName.whiteFff),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: heightScreen * 0.45),
            Text(
              widget.faceTitle ?? 'Giữ khuôn mặt nằm thẳng trong khung hình',
              style: AppTextStyle.w400s12(ColorName.whiteFff),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: heightScreen * 0.10),
            if (cameraController != null && !cameraController.value.isRecordingVideo)
              SizedBox(
                height: 80,
                width: 80,
                child: IconButton(
                  icon: Assets.images.faceConfirm.image(width: 80, height: 80),
                  color: Colors.blue,
                  onPressed: cameraController != null &&
                          cameraController.value.isInitialized &&
                          !cameraController.value.isRecordingVideo
                      ? onVideoRecordButtonPressed
                      : null,
                ),
              )
          ],
        ),
      ),
    );
  }

  void showDebug(String message) {
    print("=================$message=================");
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    final CameraController? oldController = controller;
    if (oldController != null) {
      controller = null;
      await oldController.dispose();
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        showDebug('Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          showDebug('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          showDebug('Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          // iOS only
          showDebug('Camera access is restricted.');
          break;
        case 'AudioAccessDenied':
          showDebug('You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          showDebug('Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
          // iOS only
          showDebug('Audio access is restricted.');
          break;
        default:
          _showCameraException(e);
          break;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) {
      if (mounted) {
        if (file != null) {
          widget.result(file);
        }
      }
    });
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording();
    faceTitleChenge();
    Future.delayed(const Duration(seconds: 15)).then(
      (value) => stopVideoRecording().then(
        (XFile? file) {
          if (mounted) {
            setState(() {});
          }
          if (file != null) {
            widget.result(file);
          }
        },
      ),
    );
  }

  void faceTitleChenge() {
    setState(() {
      widget.faceTitle = "Nhìn thẳng vào màn hình";
    });
    Future.delayed(const Duration(seconds: 3)).then((value) {
      setState(() {
        widget.faceTitle = "Nhìn sang trái";
      });
      Future.delayed(const Duration(seconds: 3)).then((value) {
        setState(() {
          widget.faceTitle = "Nhìn sang phải";
        });
        Future.delayed(const Duration(seconds: 3)).then((value) {
          setState(() {
            widget.faceTitle = "Nhìn lên trên";
          });
          Future.delayed(const Duration(seconds: 3)).then((value) {
            setState(() {
              widget.faceTitle = "Nhìn xuống dưới";
            });
            Future.delayed(const Duration(seconds: 3)).then((value) {
              setState(() {
                widget.faceTitle = "Nhìn thẳng vào màn hình";
              });
            });
          });
        });
      });
    });
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      showDebug('Error: select a camera first.');
      return;
    }

    if (cameraController.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      await cameraController.startVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  Future<XFile?> stopVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      return cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showDebug('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    showDebug('Error: ${e.code}\n${e.description}');
  }
}
