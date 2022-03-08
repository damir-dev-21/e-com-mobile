import 'package:get/get.dart';
import 'package:shop_app/providers/PushNotifications.dart';
import 'package:shop_app/services/database_helper.dart';
import 'package:workmanager/workmanager.dart';
import 'notification_message.dart' as notif;

const fetchBackground = "fetchBackground";
const dropUser = 'dropUser';

DatabaseHelper db = DatabaseHelper();

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    final PushNotificationsController pushN =
        Get.put(PushNotificationsController());
    switch (task) {
      case fetchBackground:
        pushN.getLastNewProd();
        notif.Notification notification = new notif.Notification();
        notification.showNotificationWithoutSound();
        break;
      case dropUser:
        await db.deleteUsers();
        break;
    }
    return Future.value(true);
  });
}
