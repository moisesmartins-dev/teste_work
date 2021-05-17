import 'package:flutter/cupertino.dart';
import 'package:teste_work/app/data/provider/ApiDog.dart';

class BreedRepository {
  final ApiDog apiDog;

  BreedRepository({@required this.apiDog}) : assert(apiDog != null);

  getAllPhotosByBreed(String breed) {
    return apiDog.fetchAllPhotosByBreed(breed);
  }
}
