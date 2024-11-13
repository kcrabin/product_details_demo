import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:product_details/core/service/local_notification_service.dart';

import 'core/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseAPI().initNotifications();
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
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF254a92)),
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
