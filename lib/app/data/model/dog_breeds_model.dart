import 'dart:convert';

DogBreedsModel dogBreedsModelFromJson(String str) => DogBreedsModel.fromJson(json.decode(str));

String dogBreedsModelToJson(DogBreedsModel data) => json.encode(data.toJson());

class DogBreedsModel {
  DogBreedsModel({
    this.message,
    this.status,
  });

  List<String> message;
  String status;

  factory DogBreedsModel.fromJson(Map<String, dynamic> json) => DogBreedsModel(
        message: List<String>.from(json["message"].map((x) => x)),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message.map((x) => x)),
        "status": status,
      };
}
