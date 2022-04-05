import 'package:awesome_notifications/awesome_notifications.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

Future<void> createPlantFoodNotification(String urlImg) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: createUniqueId(),
        channelKey: "basic_chanel",
        title: '${Emojis.clothing_shopping_bags}',
        body: 'Добавлены новые товары',
        bigPicture: urlImg,
        notificationLayout: NotificationLayout.BigPicture),
  );
}
