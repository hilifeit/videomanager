import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:videomanager/screens/chat/screens/message/models/messageModel.dart';

List<Conversation> conversationFromJson(String str) => List<Conversation>.from(
    json.decode(str).map((x) => Conversation.fromJson(x)));

String conversationToJson(List<Conversation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
      Conversation(messages: messages, receipent: receipent);

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
        receipent: json["receipent"],
      );

  Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "receipent": receipent,
      };
}
