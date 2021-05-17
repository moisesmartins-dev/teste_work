import 'package:get/get.dart';
import 'package:teste_work/app/binding/breed_binding/breed_binding.dart';
import 'package:teste_work/app/binding/home_binding/home_binding.dart';
import 'package:teste_work/app/ui/pages/breed_page/breed_page.dart';
import 'package:teste_work/app/ui/pages/home_page/home_page.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.BREED_PAGE, page: () => BreedPage(), binding: BreedBinding()),
  ];
}
