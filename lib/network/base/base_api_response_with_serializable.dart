
class BaseApiResponseWithSerializable<T extends Serializable> {
  String? message;
  T? data;

  BaseApiResponseWithSerializable({this.message, this.data});

  factory BaseApiResponseWithSerializable.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return BaseApiResponseWithSerializable<T>(
      message: json["message"],
      data: create(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": this.message,
    "data": this.data?.toJson(),
  };
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}
