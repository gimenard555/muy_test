import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muy_test/utility/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      title: 'Muy Test',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      getPages: CustomRouter.route,
      initialRoute: '/homeView',
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          color: Colors.green,
          textTheme: TextTheme(),
        ),
      ),
    ),
  );
}
