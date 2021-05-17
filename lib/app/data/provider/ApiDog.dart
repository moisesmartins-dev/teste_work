import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:teste_work/app/data/model/dog_breeds_model.dart';
import 'package:teste_work/app/data/model/photo_by_breed.dart';

const baseUrl = 'https://dog.ceo/api/breed';

class ApiDog {
  final http.Client httpClient;

  ApiDog({@required this.httpClient});

  //lista nomes das raças
  Future<DogBreedsModel> fetchAllBreedNames() async {
    try {
      var response = await httpClient.get(Uri.parse(baseUrl + 's/list'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        // print(jsonString);
        return dogBreedsModelFromJson(jsonString);
      } else {
        throw Exception('A network error occurred');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // lista fotos a partir de uma raça
  Future<PhotoByBreedModel> fetchAllPhotosByBreed(String breed) async {
    try {
      var response = await httpClient.get(Uri.parse(baseUrl + '/$breed/images'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        // print(jsonString);
        return photoByBreedModelFromJson(jsonString);
      } else {
        throw Exception('A network error occurred');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
