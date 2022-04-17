import 'dart:collection';

import 'package:event_api/event_callback.dart';

class EventEmitter {
  Map<String, List<EventCallback>> callbacks = HashMap();

  void emit(String eventName, List<dynamic>? args) {
    if (callbacks.containsKey(eventName)) {
      for (EventCallback callback in callbacks[eventName]!) {
        Function.apply(callback.callback, args);
      }

      callbacks[eventName]!.removeWhere((element) => element.once);
    }
  }

  List<String> eventNames() {
    return List.from(callbacks.keys);
  }

  int listenerCount(String eventName) {
    return callbacks[eventName] == null ? 0 : callbacks[eventName]!.length;
  }

  List<Function> listeners(String eventName) {
    if (callbacks.containsKey(eventName)) {
      return callbacks[eventName]!.map((e) => e.callback).toList();
    }
    return [];
  }

  EventEmitter removeListener(String eventName, Function listener) {
    if (callbacks.containsKey(eventName)) {
      callbacks[eventName]!
          .removeWhere((element) => element.callback == listener);
    }
    return this;
  }

  EventEmitter on(String event, Function callback) {
    if (callbacks[event] != null) {
      callbacks[event]!.add(EventCallback(callback, false));
    } else {
      callbacks[event] =
          List.filled(1, EventCallback(callback, false), growable: true);
    }
    return this;
  }

  EventEmitter once(String event, Function callback) {
    if (callbacks[event] != null) {
      callbacks[event]!.add(EventCallback(callback, true));
    } else {
      callbacks[event] =
          List.filled(1, EventCallback(callback, true), growable: true);
    }
    return this;
  }

  EventEmitter removeAllListeners(String eventName) {
    callbacks.remove(eventName);
    return this;
  }
}
