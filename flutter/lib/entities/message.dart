class Message {
  String message;
  String nickname;
  String type;

  Message(this.nickname, this.message, this.type);

  Message.fromJson(Map<String, dynamic> json)
      : nickname = json["nickname"],
        message = json['message'],
        type = json['type'];

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'message': message,
        'type': type,
      };
}
