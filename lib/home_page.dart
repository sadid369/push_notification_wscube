import 'package:flutter/material.dart';
import 'package:push_notification_wscube/notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notificationservice = NotificationService();

  @override
  void initState() {
    super.initState();
    notificationservice.initialize((details) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Text('From Notification')),
          );
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  onPressed: () {
                    notificationservice.sendNotification(
                        title: 'New Message', body: "message From Me");
                  },
                  child: Text('Notify')),
              OutlinedButton(
                  onPressed: () {
                    notificationservice.scheduleNotification(
                        id: 200, title: 'Drink Water', body: "Drink Water");
                  },
                  child: Text('Schedule Notification')),
              OutlinedButton(
                  onPressed: () {
                    notificationservice.cancelNotification(id: 100);
                  },
                  child: Text('Cancel Notification')),
            ],
          )),
    );
  }
}
