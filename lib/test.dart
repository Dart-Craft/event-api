import 'dart:io';

import 'package:event_api/event_api.dart';

//Used to check if it works.
void main(List<String> args) {
  EventEmitter emitter = EventEmitter();
  emitter.on("test", (str, str2) => {print(str), print(str2)});
  print("Hey");
  sleep(Duration(seconds: 5));

  emitter.emit("test", ["Hello World", "Do you work?"]);
}
