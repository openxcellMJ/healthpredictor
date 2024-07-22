class QuestionAnswerResponse {
  String? answer;

  QuestionAnswerResponse({this.answer});

  QuestionAnswerResponse.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer'] = answer;
    return data;
  }
}
