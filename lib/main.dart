
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/routes/app_routes.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
  //     AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);


  runApp(ProviderScope(observers: [Logger()], child: AppWidget()));
}

class AppWidget extends ConsumerWidget {
  final appRouter = AppRouter();

  AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Builder(builder: (context) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.config(),
        title: 'Product Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              color: Color(0xFF254a92),
              foregroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: Colors.white,
              )),
          primaryColor: const Color(0xFF254a92),
          colorScheme:
          ColorScheme.fromSeed(seedColor: const Color(0xFF254a92)),
          fontFamily: 'Poppins',
          useMaterial3: true,
        ),
      );
    });
  }
}

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
      ProviderBase<Object?> provider,
      Object? previousValue,
      Object? newValue,
      ProviderContainer container,
      ) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "oldValue": "$previousValue"
  "newValue": "$newValue"
}''');
  }
}
