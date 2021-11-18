class Player {
  String nickname;
  int score;
  bool correctAsnwer;

  Player(this.nickname, this.score, this.correctAsnwer);

  Player.fromJson(Map<String, dynamic> json)
      : nickname = json['nickname'],
        score = json['score'],
        correctAsnwer = json['correct_asnwer'];

  Map<String, dynamic> toJson() =>
      {'nickname': nickname, 'score': score, 'correct_asnwer': correctAsnwer};
}
