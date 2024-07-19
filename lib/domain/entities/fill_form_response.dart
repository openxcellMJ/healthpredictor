class FillFormResponse {
  String? message;
  String? predictions;

  FillFormResponse({this.message, this.predictions});

  FillFormResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    predictions = json['predictions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['predictions'] = predictions;
    return data;
  }
}