import 'package:dio/dio.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/auth_api.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/providers/remote/user_api.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/data/repositories_imp/auth_repo_impl.dart';
import 'package:flutter_go_ship_pbl6/feature/authentication/domain/repositoties/auth_repo.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/cloud_storage.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/cloud_storage_impl.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service.dart';
import 'package:flutter_go_ship_pbl6/utils/services/storage_service_impl.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/realtime_database.dart';
import 'package:flutter_go_ship_pbl6/utils/services/Firebase/realtime_database_impl.dart';
import 'package:get/instance_manager.dart';

import '../../../feature/authentication/data/repositories_imp/user_repo_impl.dart';
import '../../../feature/authentication/domain/repositoties/user_repo.dart';
import '../../base/data/remote/builder/dio_builder.dart';
import 'app_config.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    injectNetworkProvider();
    injectRepository();
    injectService();
  }

  void injectNetworkProvider() {
    Get.lazyPut(
      () => DioBuilder(
        options: BaseOptions(baseUrl: AppConfig.baseUrl),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => UserAPI(Get.find<DioBuilder>()),
      fenix: true,
    );
    Get.lazyPut(
      () => AuthAPI(Get.find<DioBuilder>()),
      fenix: true,
    );
  }

  void injectRepository() {
    Get.put<UserRepo>(UserRepoImpl());
    Get.put<AuthRepo>(AuthRepoImpl());
  }

  void injectService() {
    Get.put<StorageService>(StorageServiceImpl());
    Get.put<RealtimeDatabase>(RealtimeDatabaseImpl());
    Get.put<CloudStorage>(CloudStorageImpl());
  }
}
