import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer/bloc/cubit.dart';
import 'package:prayer/modules/splash/splash.dart';
import 'package:prayer/shared/local/notifactions.dart';
import 'package:prayer/shared/network/network.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Notifications.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrayerCubit()
        ..currentLocation(city: "Cairo", country: "Egypt")
        ..checkPrayer(),
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.deepPurple,
            appBarTheme: const AppBarTheme(
              color: Colors.deepPurple,
              elevation: 0,
            )),
        debugShowCheckedModeBanner: false,
        title: 'Prayer',
        home: const Splash(),
      ),
    );
  }
}
