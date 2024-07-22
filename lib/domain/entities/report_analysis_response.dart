class ReportAnalysisResponse {
  String? analysis;

  ReportAnalysisResponse({this.analysis});

  ReportAnalysisResponse.fromJson(Map<String, dynamic> json) {
    analysis = json['analysis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['analysis'] = this.analysis;
    return data;
  }
}
