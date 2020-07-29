import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_ussd/plugin/Languages.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  final lang;
  const AboutPage({Key key, this.lang}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.LANGUAGE[widget.lang]['aboutUs']),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  Languages.LANGUAGE[widget.lang]['aboutText'],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'thelab',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                    Text(
                      '.',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.green,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(Languages.LANGUAGE[widget.lang]['webSite']),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.language),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      child: Text('www.thelab.uz'),
                      onTap: () {
                        launch('http://thelab.uz');
                      },
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(Languages.LANGUAGE[widget.lang]['contactUs']),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/mdi_telegram.svg',
                      width: 24,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      child: Text('@AsatovShoxjahon'),
                      onTap: () {
                        launch('https://t.me/AsatovShoxjahon');
                      },
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
