import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_ussd/plugin/Connection.dart';
import 'package:mobile_ussd/plugin/Languages.dart';
import 'package:mobile_ussd/pages/MainPage/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _loading = false;
  String _text;

  @override
  Widget build(BuildContext context) {
    MaterialButton buildMaterialButton({String text, lang}) {
      return MaterialButton(
        minWidth: 185,
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        onPressed: () async {
          print('loading:$_loading');
          if (_loading) return;

          setState(() {
            _loading = true;
            _text = Languages.LANGUAGE[lang]['loadingText'];
            print('loading:$_loading');
          });

          final prefs = await SharedPreferences.getInstance();
          prefs.setString('language', lang);

          await ConnectToServer()
              .downloadAll()
              .then((value) {})
              .catchError((e) {
            print(e);
          });
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new MyHomePage()));
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
        ),
      );
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(bottom: 50),
              width: MediaQuery.of(context).size.width / 3.1,
              height: MediaQuery.of(context).size.width / 3.1,
              child: SvgPicture.asset(
                'assets/Logo.svg',
                width: 50,
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  buildMaterialButton(text: 'O`zbekcha', lang: 'uz'),
                  SizedBox(
                    height: 10,
                  ),
                  buildMaterialButton(text: 'Ўзбекча', lang: 'kk'),
                  SizedBox(
                    height: 10,
                  ),
                  buildMaterialButton(text: 'Русский', lang: 'ru'),
                ],
              ),
            ),
            if (_loading)
              Container(
                child: Text(
                  _text,
                  style:
                      TextStyle(color: Theme.of(context).secondaryHeaderColor),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
