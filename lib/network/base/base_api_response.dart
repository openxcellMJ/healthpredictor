
class BaseApiResponse<T> {
  String? message;
  T? data;
  bool? status;
  BaseApiResponse({this.message, this.data,this.status});

  factory BaseApiResponse.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return BaseApiResponse<T>(
      message: json["message"],
      status: json["status"],
      data: create(json["data"]),
    );
  }
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}
