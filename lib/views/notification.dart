import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    tz.initializeTimeZones();
    initializeSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
            child: InkWell(
                child: Container(
                  height: 50,
                  width: 230,
                  decoration: const BoxDecoration(color: Colors.teal),
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Click for Schedule Notification",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                ),
                onTap: () {
                  displayNotification();
                }),
          )),
          const SizedBox(height: 30,),
          Expanded(
              child: Align(
                alignment: Alignment.topCenter,
            child: InkWell(
                child: Container(
                  height: 50,
                  width: 230,
                  decoration: const BoxDecoration(color: Colors.teal),
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Click for Basic Notification",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                ),
                onTap: () {
                  displayBasicNotification();
                }),
          ))
        ],
      ),
    );
  }

  Future<void> displayNotification() async {
    notificationsPlugin.zonedSchedule(
        0,
        "Schedule Notification",
        "Notification generated",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'channel id',
          'cahnnel name',
        )),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  Future<void> displayBasicNotification() async {
    notificationsPlugin.show(
        0,
        "Basic Notification",
        "Notification generated",
        const NotificationDetails(
            android: AndroidNotificationDetails('channel id', 'channel name')));
  }
}

void initializeSetting() async {
  var initilizeAndroid = const AndroidInitializationSettings('notiicon');
  var initilizseSetting = InitializationSettings(android: initilizeAndroid);
  await notificationsPlugin.initialize(initilizseSetting);
}
