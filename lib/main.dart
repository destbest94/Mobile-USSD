import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ussd/pages/MainPage/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        primaryColor: Color(0xFFE31E24),
        secondaryHeaderColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: 'USSD',
          theme: theme,
          home: MyHomePage(title: 'USSD'),
        );
      },
    );
  }
}
