class UploadResponse {
  String? message;
  String? sessionId;

  UploadResponse({this.message, this.sessionId});

  UploadResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    sessionId = json['session_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['session_id'] = this.sessionId;
    return data;
  }
}
