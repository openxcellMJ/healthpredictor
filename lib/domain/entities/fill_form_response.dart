class FillFormResponse {
  String? message;
  String? predictions;
  String? sessionId;

  FillFormResponse({this.message, this.predictions, this.sessionId});

  FillFormResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    predictions = json['predictions'];
    sessionId = json['session_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['predictions'] = predictions;
    data['session_id'] = sessionId;
    return data;
  }
}
