import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:teste_work/app/controller/breed_controller/breed_controller.dart';
import 'package:teste_work/app/data/provider/ApiDog.dart';
import 'package:teste_work/app/data/repository/breed_repository.dart';

class BreedPage extends StatefulWidget {
  @override
  _BreedPage createState() => _BreedPage();
}

class _BreedPage extends State<BreedPage> {
  final BreedController rxController = BreedController(breedRepository: BreedRepository(apiDog: ApiDog(httpClient: http.Client())));
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
    // TODO: implement initState
    scrollController.addListener(
      () {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          if (rxController.sizeList.value < rxController.dogBreedPhotoList.value.message.length) {
            rxController.changeSize();
            print('1 - sizeList => ' + rxController.sizeList.value.toString());
            print('2 - dogBreedListSize => ' + rxController.dogBreedPhotoList.value.message.length.toString());
            print('3 - is remaining => ' + rxController.sizeRemaining.value.toString());
          } else if (rxController.sizeList.value >= rxController.dogBreedPhotoList.value.message.length) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            print('1 - sizeList => ' + rxController.sizeList.value.toString());
            print('2 - dogBreedListSize => ' + rxController.dogBreedPhotoList.value.message.length.toString());
            print('3 - is remaining => ' + rxController.sizeRemaining.value.toString());
            print('nao tem');
            // showSnack();
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    rxController.init(args);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          args,
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
                        // itemCount: rxController.dogBreedList.value.message.length,
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
