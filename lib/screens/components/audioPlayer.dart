import 'package:audioplayers/audioplayers.dart';

final AudioPlayer player = AudioPlayer();

class CustomAudioPlayer {
  CustomAudioPlayer._();

  static messageSent() {
    player.play(AssetSource('sounds/message_sent.mp3'));
  }

  static messageReceived() {
    player.play(AssetSource('sounds/message_received.mp3'));
  }

  static messageTyping() {
    player.play(AssetSource('sounds/message_typing.mp3'));
    player.setVolume(20);
  }

  static messageDelivered() {
    player.play(AssetSource('sounds/message_delivered.mp3'));
  }

  static notification() {
    player.play(AssetSource('sounds/message_notification.mp3'));
  }
}
