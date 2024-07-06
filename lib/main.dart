// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Binding/binding.dart';
import 'package:giftappgp/Services/Localization.dart';
import 'package:giftappgp/Services/StorageKeys.dart';
import 'package:giftappgp/View/Screens/Admin/aHome.dart';
import 'package:giftappgp/View/Screens/Auth/Login.dart';
import 'package:giftappgp/View/Screens/Home/mainContainer.dart';

import 'package:giftappgp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

late FirebaseMessaging messaging;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  messaging = FirebaseMessaging.instance;

  messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    sound: true,
    badge: true,
  );

  //NotificationSettings settings
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    provisional: true,
  );
  Stripe.publishableKey = Storagekeys.strpi_pk;
  await Stripe.instance.applySettings();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(app());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

forgroundnotifocations() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {}
  });
}

class app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Localization(),
      locale: Locale('ar'),
      initialBinding: Binding(),
      home: Login(),
    );
  }
}
