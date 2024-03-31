import 'dart:io';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

void main() async {
  var botToken = 'YOURE_TOKEN_BOT';  //FROM BOTFATHER 
  var adminUser = "YOUR_USERNAME_TELEGRAM"; //EXMAPLE  @admin
  final username = (await Telegram(botToken).getMe()).username;
  var teledart = TeleDart(botToken, Event(username!));

  teledart.start();

  // When a new user starts the bot, store their ID in a file
  teledart.onCommand('start').listen((message) async {
    message.reply('Welcome : مرحبا');
    var file = File('user_ids.txt');
    var id = message.from?.id.toString();
    if (id != null) {
      var ids = await file.readAsLines();
      var idSet = ids.toSet();
      if (idSet.add(id)) {
        await file.writeAsString(idSet.join('\n'));
        message.reply('مرحبا بك !');
      }
    }
  });

  // When the admin sends the broadcast command, ask for the message
  teledart.onCommand('broadcast').listen((message) async {
    if (message.from?.username == adminUser) {
      // replace 'admin' with the actual admin username
      message.reply('Please send the message you want to broadcast.');
      teledart
          .onMessage()
          .firstWhere((msg) => msg.from?.id == message.from?.id)
          .asStream() // Convert Future to Stream
          .listen((msg) async {
        var file = File('user_ids.txt');
        var ids = await file.readAsLines();
        var text = msg.text;
        if (text != null && text.isNotEmpty) {
          for (var id in ids) {
            try {
              teledart.sendMessage(int.parse(id), text);
            } catch (e) {
              print('Failed to send message to $id: $e');
            }
          }
          message.reply('تم الارسال بنجاح !');
        } else {
          message.reply('Failed to send message.');
        }
      });
    }
  });
}
