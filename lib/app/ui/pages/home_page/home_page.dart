import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_work/app/controller/home_controller/home_controller.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:teste_work/app/data/provider/ApiDog.dart';
import 'package:teste_work/app/data/repository/home_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController rxController = HomeController(homeRepository: HomeRepository(apiDog: ApiDog(httpClient: http.Client())));

  @override
  void initState() {
    // TODO: implement initState
    rxController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dog Breeds',
          style: TextStyle(
            fontSize: 17.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white10,
        child: RxBuilder(
          builder: (_) => rxController.loading.value
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: rxController.dogBreedList.value.message.length,
                  itemBuilder: (_, index) {
                    return Card(
                      margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Navigator.pushNamed(context, '/breed', arguments: rxController.dogBreedList.value.message[index]);
                        },
                        child: Container(
                          height: 08.h,
                          // width: 20.w,
                          child: Center(
                            child: Text(
                              rxController.dogBreedList.value.message[index].toString(),
                              style: TextStyle(fontSize: 15.sp),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
