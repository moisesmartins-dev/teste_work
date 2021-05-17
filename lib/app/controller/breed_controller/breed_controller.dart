import 'package:flutter/cupertino.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:teste_work/app/data/model/photo_by_breed.dart';
import 'package:teste_work/app/data/repository/breed_repository.dart';

class BreedController {
  final BreedRepository breedRepository;

  BreedController({@required this.breedRepository}) : assert(breedRepository != null);

  //lista de fotos
  var dogBreedPhotoList = RxNotifier<PhotoByBreedModel>(null);

  //paginação de 10 itens e tamanho da lista inicial(lista de exibição)
  var sizeList = RxNotifier<int>(10);
  var loading = RxNotifier<bool>(false);

  //tamanha restante, resultado da lista de fotos - lista de exibição
  var sizeRemaining = RxNotifier<int>(0);
  String breed;

  init(breed) {
    breedRepository.getAllPhotosByBreed(breed).then(
      (value) {
        dogBreedPhotoList.value = value;
        /*10 por padrao.
          se o tamanho da lista de fotos da raça for menor do que 10, o tamanho será o tamanho da lista de fotos da raça */
        if (dogBreedPhotoList.value.message.length < sizeList.value) {
          sizeList.value = dogBreedPhotoList.value.message.length;
        }
        sizeRemaining.value = dogBreedPhotoList.value.message.length - sizeList.value;
        loading.value = value.message.isNotEmpty;
      },
    );
  }

  void changeSize() {
    sizeRemaining.value = dogBreedPhotoList.value.message.length - sizeList.value;
    if (sizeRemaining.value < 10) {
      sizeList.value = sizeList.value + sizeRemaining.value;
    } else {
      sizeList.value = sizeList.value + 10;
    }
  }

/*
    Toda vez que chamar changeSize(), acontecera o seguinte
    - Ele vai obter sizeRemaining que será o tamanho restante a partir resultado da subtração da lista de fotos pela lista de exibição

    Se sizeRemaining for menor do 10, neste caso o tamanho da lista de exibição sera somado mais o tamanho restante(sizeRemaining)

    Senão o tamanho da lista de exibição sera incrementa em 10
    */
}
