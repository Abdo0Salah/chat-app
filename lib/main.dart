import 'package:chat_app/providers/my_provider.dart';
import 'package:chat_app/screens/add_rome/add_room_screen.dart';
import 'package:chat_app/screens/chat/chat_screen.dart';
import 'package:chat_app/screens/creat_account/creat_account_view.dart';
import 'package:chat_app/screens/home_screen/home_view.dart';
import 'package:chat_app/screens/login/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
bool isFlutterLocalNotificationsInitialized = false;
late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await setupFlutterNotifications();
  showFlutterNotification(message);

}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  printFCMToken();
  setupFlutterNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: MyApp()));
}

Future<String?> printFCMToken() async {
  String? token = await messaging.getToken();
  return token;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      initialRoute: provider.firebaseUser != null
          ? HomeScreenView.routeName
          : LoginView.routeName,
      debugShowCheckedModeBanner: false,
      routes: {
        CreatAccount.routeName: (context) => CreatAccount(),
        LoginView.routeName: (context) => LoginView(),
        HomeScreenView.routeName: (c) => HomeScreenView(),
        ChatScreen.routeName: (c) => ChatScreen(),
        AddRoomScreen.routeName: (c) => AddRoomScreen()
      },
    );
  }
}


