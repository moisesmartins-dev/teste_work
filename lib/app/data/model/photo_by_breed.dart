import 'dart:convert';

PhotoByBreedModel photoByBreedModelFromJson(String str) => PhotoByBreedModel.fromJson(json.decode(str));

String photoByBreedModelToJson(PhotoByBreedModel data) => json.encode(data.toJson());

class PhotoByBreedModel {
  PhotoByBreedModel({
    this.message,
    this.status,
  });

  List<String> message;
  String status;

  factory PhotoByBreedModel.fromJson(Map<String, dynamic> json) => PhotoByBreedModel(
        message: List<String>.from(json["message"].map((x) => x)),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message.map((x) => x)),
        "status": status,
      };
}
