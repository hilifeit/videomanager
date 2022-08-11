class Message {
    Message({
        required this.sender,
        required this.receiver,
        required this.message,
        required this.createdAt,
    });

    final String sender;
    final String receiver;
    final String message;
    final DateTime createdAt;

    Message copyWith({
      required String sender,
      required  String receiver,
      required  String message,
      required  DateTime createdAt,
    }) => 
        Message(
            sender: sender, 
            receiver: receiver ,
            message: message ,
            createdAt: createdAt ,
        );

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        sender: json["sender"],
        receiver: json["receiver"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "sender": sender,
        "receiver": receiver,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
    };
}
