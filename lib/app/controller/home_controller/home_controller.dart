import 'package:flutter/cupertino.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:teste_work/app/data/model/dog_breeds_model.dart';
import 'package:teste_work/app/data/repository/home_repository.dart';

class HomeController {
  final HomeRepository homeRepository;

  HomeController({@required this.homeRepository}) : assert(homeRepository != null);

  var dogBreedList = RxNotifier<DogBreedsModel>(null);
  var sizeList = RxNotifier<int>(0);
  var loading = RxNotifier<bool>(false);

  init() {
    homeRepository.getAllBreeds().then(
      (value) {
        dogBreedList.value = value;
        sizeList.value = value.message.length;
        loading.value = value.message.isNotEmpty;
      },
    );
  }
}
