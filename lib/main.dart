import 'package:flutter/material.dart';

import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// setup navigator
      initialRoute: Routes.home,
      routes: Routes.list,

      /// always remove debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}
