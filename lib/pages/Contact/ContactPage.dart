import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_ussd/plugin/Languages.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  final String lang;
  ContactPage({Key key, this.lang}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.LANGUAGE[widget.lang]['contactWithDealer']),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              Languages.LANGUAGE[widget.lang]['contactWithDealer'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Icon(Icons.email),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Text('AkramovAmirxonXk@gmail.com'),
                  onTap: () {
                    launch('mailto:AkramovAmirxonXk@gmail.com');
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/mdi_telegram.svg',
                  width: 24,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Text('@uzmobile_mobiuz_beeline_ussd'),
                  onTap: () {
                    launch('https://t.me/uzmobile_mobiuz_beeline_ussd');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
