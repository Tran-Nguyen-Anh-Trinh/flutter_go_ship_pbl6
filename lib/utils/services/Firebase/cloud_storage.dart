import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class CloudStorage {
  Future<List<String>> putAllFile(List<File> files);
  Future<List<String>> putAllxFile(List<XFile> xfiles, {String folder = "shipper"});
}
