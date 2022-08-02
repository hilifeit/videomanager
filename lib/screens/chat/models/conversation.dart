import 'package:meta/meta.dart';
import 'dart:convert';

List<Conversation> conversationFromJson(String str) => List<Conversation>.from(json.decode(str).map((x) => Conversation.fromJson(x)));

String conversationToJson(List<Conversation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Conversation {
    Conversation({
        required this.messages,
        required this.receipent,
    });

    final List<Message> messages;
    final String receipent;

    Conversation copyWith({
        required List<Message> messages,
        required String receipent,
    }) => 
        Conversation(
            messages: messages ,
            receipent: receipent 
        );

    factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
        receipent: json["receipent"],
    );

    Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "receipent": receipent,
    };
}

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
