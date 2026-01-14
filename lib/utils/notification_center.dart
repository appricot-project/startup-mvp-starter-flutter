enum NotificationKey { routeChanged }

class NotificationCenter {
  final _observers = <String, Map<String, Function>>{};

  static final NotificationCenter _instance = NotificationCenter.internal();
  factory NotificationCenter() => _instance;
  NotificationCenter.internal();

  void subscribe<T>(
    T subscriber,
    NotificationKey notificationKey,
    Function(dynamic) callback,
  ) {
    var notificationId = notificationKey.toString();
    var subscriberId = _getSubscriberId<T>(subscriber);

    if (!_observers.containsKey(notificationId)) {
      _observers[notificationId] = {};
    }

    _observers[notificationId]![subscriberId] = callback;
  }

  void unsubscribe<T>(T subscriber, NotificationKey notificationKey) {
    var notificationId = notificationKey.toString();
    var subscriberId = _getSubscriberId<T>(subscriber);

    _observers[notificationId]?.remove(subscriberId);

    if (_observers[notificationId]?.isEmpty == true) {
      _observers.remove(notificationId);
    }
  }

  String _getSubscriberId<T>(T subscriber) {
    return '${T.toString()}-${subscriber.hashCode}';
  }

  void notify(NotificationKey notificationKey, {dynamic data}) {
    var notificationId = notificationKey.toString();
    if (_observers.containsKey(notificationId)) {
      final observers = Map<String, Function>.from(_observers[notificationId]!);

      for (final callback in observers.values) {
        try {
          callback(data);
        } catch (e) {
          print('Ошибка в callback для $notificationKey: $e');
        }
      }
    }
  }

  void printSubscribers(NotificationKey notificationKey) {
    var notificationId = notificationKey.toString();
    print('Подписчики для $notificationId:');
    _observers[notificationId]?.forEach((subscriberId, _) {
      print('  - $subscriberId');
    });
  }
}
