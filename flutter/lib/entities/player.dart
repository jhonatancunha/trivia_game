class Player {
  String nickname;
  int score;

  Player(this.nickname, this.score);

  Player.fromJson(Map<String, dynamic> json)
      : nickname = json['nickname'],
        score = json['score'];

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'score': score,
      };
}