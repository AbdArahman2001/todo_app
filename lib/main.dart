import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/bloc/bloc_observer.dart';
import 'helpers/sqflite_helper.dart';
import 'screens/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SqFliteHelper.sqFliteHelper.createDataBase();
  Bloc.observer = MyBlocObserver();
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [Locale('en'), Locale('ar')],
    path: 'assets/langs',
    fallbackLocale: Locale('en'),
    startLocale: Locale('en'),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.black,
        buttonColor: Colors.black,
        canvasColor: Color.fromRGBO(51, 48, 48, 1),
      ),
      themeMode: ThemeMode.light,
      home: HomeScreen(),
    );
  }
}
