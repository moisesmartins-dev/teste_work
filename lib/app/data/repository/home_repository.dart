import 'package:meta/meta.dart';
import 'package:teste_work/app/data/provider/ApiDog.dart';

class HomeRepository {
  final ApiDog apiDog;

  HomeRepository({@required this.apiDog}) : assert(apiDog != null);

  getAllBreeds() {
    return apiDog.fetchAllBreedNames();
  }
}
