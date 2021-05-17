import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:teste_work/app/controller/breed_controller/breed_controller.dart';
import 'package:teste_work/app/data/provider/ApiDog.dart';
import 'package:teste_work/app/data/repository/breed_repository.dart';

class BreedBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BreedController>(() {
      return BreedController(
        breedRepository: BreedRepository(
          apiDog: ApiDog(
            httpClient: http.Client(),
          ),
        ),
      );
    });
    // TODO: implement dependencies
  }
}
