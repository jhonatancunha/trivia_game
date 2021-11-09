class RoundInfo {
  String theme = '';
  String hint = '';
  String answer = '';

  RoundInfo(this.theme, this.hint, this.answer);

  RoundInfo.fromJson(Map<String, dynamic> json)
      : theme = json["theme"],
        hint = json['hint'],
        answer = json['answer'];

  Map<String, dynamic> toJson() => {
        'theme': theme,
        'hint': hint,
        'answer': answer,
      };
}
