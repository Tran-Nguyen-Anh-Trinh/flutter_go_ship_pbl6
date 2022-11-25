import 'package:camera/camera.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_controller.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/camera_widget.dart';

class ConfirmCameraController extends BaseController<TypeCamera> {
  RxList<CameraDescription> cameras = List<CameraDescription>.empty().obs;

  TypeCamera? typeCamera;

  var faceTitle = "".obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    typeCamera = input;
    WidgetsFlutterBinding.ensureInitialized();
    cameras.value = await availableCameras();
  }


}
