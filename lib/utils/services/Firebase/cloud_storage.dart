import 'dart:io';

abstract class CloudStorage {
  Future<List<String>> putAllFile(List<File> files);
}