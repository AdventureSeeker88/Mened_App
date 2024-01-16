import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/provider/call_pro.dart';
import 'package:mended/provider/flicks_pro.dart';
import 'package:mended/provider/group_pro.dart';
import 'package:mended/provider/memeland_pro.dart';
import 'package:mended/provider/notification_pro.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/views/chat/pro/ChatPro.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

//new
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBSJ7DobaZWugvIiCJwJ_jvIrryLINqKbI",
        authDomain: "melodic-metrics-383421.firebaseapp.com",
        projectId: "melodic-metrics-383421",
        storageBucket: "melodic-metrics-383421.appspot.com",
        messagingSenderId: "259392011191",
        appId: "1:259392011191:web:320d7cb21903162e434632",
        measurementId: "G-W5RF9L8YGY",
      ),
    );
  } else {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthPro>(
          create: (_) => AuthPro(),
        ),
        ChangeNotifierProvider<MemelandPro>(
          create: (_) => MemelandPro(),
        ),
        ChangeNotifierProvider<GroupPro>(
          create: (_) => GroupPro(),
        ),
        ChangeNotifierProvider<FlicksPro>(
          create: (_) => FlicksPro(),
        ),
        ChangeNotifierProvider<ChatPro>(
          create: (_) => ChatPro(),
        ),
        ChangeNotifierProvider<CallPro>(
          create: (_) => CallPro(),
        ),
        ChangeNotifierProvider<NotificationPro>(
          create: (_) => NotificationPro(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: Routes().myrouter,
        title: 'Mended',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Palette.themecolor,
          useMaterial3: true,
          indicatorColor: Colors.white,
          focusColor: Colors.white,
          hintColor: Colors.white,
        ),
        builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 1900,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.resize(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1000, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1900, name: DESKTOP),
          ],
        ),
      ),
    );
  }
}
