import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rx_notifier/rx_notifier.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_work/app/controller/breed_controller/breed_controller.dart';
import 'package:teste_work/app/data/provider/ApiDog.dart';
import 'package:teste_work/app/data/repository/breed_repository.dart';

class BreedPage extends StatefulWidget {
  @override
  _BreedPage createState() => _BreedPage();
}

class _BreedPage extends State<BreedPage> {
  final BreedController rxController =
      BreedController(breedRepository: BreedRepository(apiDog: ApiDog(httpClient: http.Client())));
  ScrollController scrollController = ScrollController();
  String breed;

  var snackBar = SnackBar(
    content: Text('Fim da lista'),
    duration: Duration(seconds: 1),
  );

  @override
  void dispose() {
    scrollController.dispose();
    rxController.dogBreedPhotoList.dispose();
    super.dispose();
  }

  @override
  void initState() {
    breed = Get.arguments;
    rxController.init(breed);
    /*  como a API não possui paginação, tive que implementar na mão. A screen de cada raça ja começa com 10.
        scrollController vai ouvir a rolagem da tela e toda vez que a posição de rolagem for igual a parte inferior da tela
        ele aumenta em 10 o tamanho da lista  ↓*/
    scrollController.addListener(
      () {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          //se o tamanho da lista de exibicao for menor do que a lista de fotos da raça, ele aumenta.
          if (rxController.sizeList.value < rxController.dogBreedPhotoList.value.message.length) {
            rxController.changeSize();
          } //se maior ou igual, ele exibi um snackBar informando o fim da list
          else if (rxController.sizeList.value >= rxController.dogBreedPhotoList.value.message.length) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          breed,
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: RxBuilder(
                builder: (_) => rxController.loading.value
                    ? ListView.builder(
                        controller: scrollController,
                        itemCount: rxController.sizeList.value,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(rxController.dogBreedPhotoList.value.message[index]),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
