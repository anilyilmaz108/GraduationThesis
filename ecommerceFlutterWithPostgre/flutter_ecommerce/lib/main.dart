import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/services/auth_service.dart';
import 'package:flutter_ecommerce/services/data_service.dart';
import 'package:flutter_ecommerce/services/database_service.dart';
import 'package:flutter_ecommerce/services/image_service.dart';
import 'package:flutter_ecommerce/services/notification_service.dart';
import 'package:flutter_ecommerce/views/beginning.dart';
import 'package:flutter_ecommerce/views/splash_view.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);



  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<ImageService>(create: (BuildContext context) => ImageService()),
        ChangeNotifierProvider<AuthService>(create: (BuildContext context) => AuthService()),
        ChangeNotifierProvider<DatabaseService>(create: (BuildContext context) => DatabaseService()),
        ChangeNotifierProvider<NotificationService>(create: (BuildContext context) => NotificationService()),
      ],
      child: MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GiysiDolabı',
      theme: ThemeData(
        //scaffoldBackgroundColor: Colors.orange,
        primarySwatch: Colors.orange,
        fontFamily: "Gordita",
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.black54),
        ),
      ),
      home: SplashView(),
    );
  }
}
