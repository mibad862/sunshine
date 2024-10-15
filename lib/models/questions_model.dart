class QuestionModel {
  QuestionModel({
    required this.id,
    required this.value,
    required this.question,
    required this.color,
  });

  final dynamic id;
  final String? value;
  final String? question;
  final String? color;

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json["id"],
      value: json["value"],
      question: json["question"],
      color: json["color"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "question": question,
        "color": color,
      };
}
