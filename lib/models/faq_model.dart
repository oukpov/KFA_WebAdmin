class FaqModel {
  String? id;
  String? question;
  String? answer;
  String? createAt;

  FaqModel({this.id, this.question, this.answer, this.createAt});

  FaqModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    question = json['question'] ?? '';
    answer = json['answer'] ?? '';
    createAt = json['create_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? '';
    data['question'] = this.question ?? '';
    data['answer'] = this.answer ?? '';
    data['create_at'] = this.createAt ?? '';
    return data;
  }
}
