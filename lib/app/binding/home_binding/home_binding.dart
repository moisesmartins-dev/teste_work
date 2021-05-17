import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:teste_work/app/controller/home_controller/home_controller.dart';
import 'package:teste_work/app/data/provider/ApiDog.dart';
import 'package:teste_work/app/data/repository/home_repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () {
        return HomeController(
          homeRepository: HomeRepository(
            apiDog: ApiDog(
              httpClient: http.Client(),
            ),
          ),
        );
      },
    );
  }
}
