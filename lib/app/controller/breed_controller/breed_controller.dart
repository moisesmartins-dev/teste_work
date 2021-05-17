import 'package:flutter/cupertino.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:teste_work/app/data/model/photo_by_breed.dart';
import 'package:teste_work/app/data/repository/breed_repository.dart';

class BreedController {
  final BreedRepository breedRepository;

  BreedController({@required this.breedRepository}) : assert(breedRepository != null);

  //lista de fotos
  var dogBreedPhotoList = RxNotifier<PhotoByBreedModel>(null);

  //paginação de 10 itens
  var sizeList = RxNotifier<int>(10);
  var numText = RxNotifier<int>(0);
  var loading = RxNotifier<bool>(false);
  var sizeRemaining = RxNotifier<int>(0);
  String breed;

  init(breed) {
    breedRepository.getAllPhotosByBreed(breed).then(
      (value) {
        dogBreedPhotoList.value = value;
        // 10 por padrao
        if (dogBreedPhotoList.value.message.length < sizeList.value) {
          sizeList.value = dogBreedPhotoList.value.message.length;
        }
        sizeRemaining.value = dogBreedPhotoList.value.message.length - sizeList.value;
        print('1 - sizeList => ' + sizeList.value.toString());
        print('2 - dogBreedListSize => ' + dogBreedPhotoList.value.message.length.toString());
        print('3 - is remaining => ' + sizeRemaining.value.toString());

        loading.value = value.message.isNotEmpty;
      },
    );
  }

  void changeSize() {
    sizeRemaining.value = dogBreedPhotoList.value.message.length - sizeList.value;
    if (sizeRemaining.value < 10) {
      sizeList.value = dogBreedPhotoList.value.message.length;
    } else {
      sizeRemaining.value = dogBreedPhotoList.value.message.length - sizeList.value;
      sizeList.value = sizeList.value + 10;
    }
  }
}
