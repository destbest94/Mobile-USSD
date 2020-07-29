import 'package:carousel_slider/carousel_slider.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_ussd/pages/Contact/ContactPage.dart';
import 'package:mobile_ussd/plugin/Connection.dart';
import 'package:mobile_ussd/plugin/Languages.dart';
import 'package:mobile_ussd/pages/About/AboutPage.dart';
import 'package:mobile_ussd/pages/ShowInternet/ShowInternetGroupPage.dart';
import 'package:mobile_ussd/pages/ShowMessage/ShowMessageGroupPage.dart';
import 'package:mobile_ussd/pages/ShowMinute/ShowMinuteGroupPage.dart';
import 'package:mobile_ussd/pages/ShowNews/ShowNewsGroupPage.dart';
import 'package:mobile_ussd/pages/ShowService/ShowServiceGroupPage.dart';
import 'package:mobile_ussd/pages/ShowTarif/ShowTariffGroupPage.dart';
import 'package:mobile_ussd/pages/ShowUssd/ShowUssdGroupPage.dart';
import 'package:mobile_ussd/pages/MainPage/components/SplashPage.dart';
import 'package:mobile_ussd/pages/WebviewPage/WebviewPage.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CarouselController _controller = CarouselController();

  int _current = 0;

  Future<String> getLang() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('language') ?? '';
  }

  @override
  void initState() {
    //ConnectToServer().downloadAll().then((value) => null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double sectionWidth = screenSize.width * 0.46;
    double sectionHeight = screenSize.height * 0.18;
    final List<String> operatorsNameDraw = [
      'Mobiuz',
      'Uzmobile',
      'Ucell',
      'Beeline',
      'Perfectum',
    ];
    final List<Widget> operatorsLogo = [
      Center(
        child: SvgPicture.asset(
          'assets/MobiuzLogo.svg',
          width: 150,
          color: Theme.of(context).secondaryHeaderColor,
        ),
      ),
      Center(
        child: SvgPicture.asset(
          'assets/UzmobLogo.svg',
          width: 180,
          color: Theme.of(context).secondaryHeaderColor,
        ),
      ),
      Center(
        child: SvgPicture.asset(
          'assets/UcellLogo.svg',
          width: 100,
          color: Theme.of(context).secondaryHeaderColor,
        ),
      ),
      Center(
        child: SvgPicture.asset(
          'assets/BeelineLogo.svg',
          width: 120,
          color: Theme.of(context).secondaryHeaderColor,
        ),
      ),
      Center(
        child: SvgPicture.asset(
          'assets/PerfectumLogo.svg',
          width: 150,
          color: Theme.of(context).secondaryHeaderColor,
        ),
      ),
    ];
    final List<Color> operatorsTheme = [
      Color(0xFFE31E24),
      Color(0xFF00AFF0),
      Color(0xFF652D86),
      Color(0xFFFFCD1D),
      Color(0xFFFD5009),
    ];
    final specialUssd = {
      'Mobiuz': [
        '*102#',
        '*100#',
        '0890',
        '*103#',
      ],
      'Uzmobile': [
        '*100*2#',
        '*107#',
        '1099',
        '*100*2#',
      ],
      'Ucell': [
        '*107#',
        '*100#',
        '8123',
        '*102#',
      ],
      'Beeline': [
        '*103#',
        '*102#',
        '0611',
        '*106#',
      ],
      'Perfectum': [
        '9*6',
        '9*1',
        '077',
        '9*6',
      ],
    };
    final List<String> urls = [
      'https://ip.mobi.uz/selfcare/',
      'https://cabinet.uztelecom.uz/ps/scc/login.php',
      'https://my.ucell.uz/Account/Login?ReturnUrl=%2F',
      'https://beeline.uz/uz/signin',
      'https://my.perfectum.uz/login.php',
    ];

    return FutureBuilder(
      future: getLang(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == '') {
            return SplashPage();
            //Navigator.push(context, MaterialPageRoute(builder: (context) => SplashPage()));
          } else {
            return Scaffold(
              resizeToAvoidBottomPadding: false,
              appBar: AppBar(
                elevation: 0.0,
                iconTheme: IconThemeData(
                    color: Theme.of(context).secondaryHeaderColor),
                actions: <Widget>[
                  Flexible(
                    child: IconButton(
                      alignment: Alignment(-0.5, 0.0),
                      icon: Icon(
                        Icons.share,
                        // color: Theme.of(context).secondaryHeaderColor,
                      ),
                      onPressed: () {
                        Share.share(Languages.LANGUAGE[snapshot.data]
                                ['shareText'] +
                            'https://play.google.com/store/apps/details?id=uz.thelab.mobile_ussd');
                      },
                    ),
                  ),
                  Flexible(
                    child: RawMaterialButton(
                      shape: CircleBorder(),
                      constraints: BoxConstraints.tight(Size(36, 36)),
                      child: SvgPicture.asset(
                        'assets/mdi_telegram.svg',
                        width: 24,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      onPressed: () {
                        launch('https://t.me/uzmobile_mobiuz_beeline_ussd');
                      },
                    ),
                  ),
                  Flexible(
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications,
                        // color: Theme.of(context).secondaryHeaderColor,
                      ),
                      onPressed: () async {
                        dynamic group = await ConnectToServer().getNews(
                          mobileOperator: operatorsNameDraw[_current],
                        );
                        if (group.length == 0) {
                          group = await ConnectToServer()
                              .getNews(mobileOperator: '');
                        }
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => ShowNewsGroupPage(
                                mobileOperator: operatorsNameDraw[_current],
                                lang: snapshot.data,
                                title: Languages.LANGUAGE[snapshot.data]
                                    ['newsTitle'],
                                model: group,
                              ),
                              transitionDuration: Duration(seconds: 0),
                            ));
                      },
                    ),
                  ),
                  Flexible(
                    child: IconButton(
                      icon: Icon(
                        Icons.account_circle,
                        // color: Theme.of(context).secondaryHeaderColor,
                      ),
                      onPressed: () async {
                        dynamic group = await ConnectToServer().getNews(
                          mobileOperator: operatorsNameDraw[_current],
                        );
                        if (group.length == 0) {
                          group = await ConnectToServer()
                              .getNews(mobileOperator: '');
                        }
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => WebviewPage(
                                  title: Languages.LANGUAGE[snapshot.data]
                                      ['accountTitle'],
                                  url: urls[_current]),
                              transitionDuration: Duration(seconds: 0),
                            ));
                      },
                    ),
                  ),
                ],
              ),
              drawer: Drawer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                              height: screenSize.height * 0.3,
                              width: screenSize.width,
                              padding: EdgeInsets.all(20),
                              color: Theme.of(context).primaryColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Container(
                                      child: Text(
                                        operatorsNameDraw[_current],
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .secondaryHeaderColor,
                                            fontSize: 24),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '"AKRAMOV AMIRXON" X/K',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .secondaryHeaderColor
                                            .withOpacity(0.7),
                                        fontSize: 14),
                                  ),
                                ],
                              )),
                          ListTile(
                            leading: SvgPicture.asset(
                              'assets/mdi_telegram.svg',
                              width: 24,
                              color: Colors.black38,
                            ),
                            title: Text(
                                Languages.LANGUAGE[snapshot.data]['telegram']),
                            onTap: () {
                              launch(
                                  'https://t.me/uzmobile_mobiuz_beeline_ussd');
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.mail),
                            title: Text(
                                Languages.LANGUAGE[snapshot.data]['contact']),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => ContactPage(
                                      lang: snapshot.data,
                                    ),
                                    transitionDuration: Duration(seconds: 0),
                                  ));
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.g_translate),
                            title: Text(
                                Languages.LANGUAGE[snapshot.data]['language']),
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => SplashPage()));
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.import_export),
                            title: Text(
                                Languages.LANGUAGE[snapshot.data]['speed']),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => WebviewPage(
                                        title: Languages.LANGUAGE[snapshot.data]
                                            ['speed'],
                                        url: 'https://fast.com/'),
                                    transitionDuration: Duration(seconds: 0),
                                  ));
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.stars),
                            title: Text(
                                Languages.LANGUAGE[snapshot.data]['rating']),
                            onTap: () {
                              launch(
                                  'https://play.google.com/store/apps/details?id=uz.thelab.mobile_ussd');
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.supervised_user_circle),
                            title: Text(
                                Languages.LANGUAGE[snapshot.data]['aboutUs']),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => AboutPage(
                                      lang: snapshot.data,
                                    ),
                                    transitionDuration: Duration(seconds: 0),
                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          (snapshot.data == 'ru')
                              ? Text(
                                  Languages.LANGUAGE[snapshot.data]['thelab'],
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                )
                              : SizedBox.shrink(),
                          Text(
                            "thelab",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                          Text(
                            ".",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          ),
                          (snapshot.data != 'ru')
                              ? Text(
                                  Languages.LANGUAGE[snapshot.data]['thelab'],
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: <Widget>[
                        Align(
                          child: Text(
                              Languages.LANGUAGE[snapshot.data]['mTitle'],
                              style: TextStyle(
                                  color:
                                      Theme.of(context).secondaryHeaderColor)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: IconButton(
                                iconSize: 40,
                                onPressed: () => _controller.previousPage(),
                                icon: Icon(
                                  Icons.keyboard_arrow_left,
                                  color: Theme.of(context)
                                      .secondaryHeaderColor
                                      .withOpacity(0.7),
                                  size: 40,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                child: CarouselSlider(
                                  items: operatorsLogo,
                                  options: CarouselOptions(
                                      enlargeCenterPage: true,
                                      viewportFraction: 1,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _current = index;
                                          DynamicTheme.of(context)
                                              .setThemeData(ThemeData(
                                            primaryColor: operatorsTheme[index],
                                            secondaryHeaderColor: index == 3
                                                ? Colors.black87
                                                : Colors.white,
                                          ));
                                        });
                                      }),
                                  carouselController: _controller,
                                ),
                              ),
                            ),
                            Center(
                              child: IconButton(
                                iconSize: 40,
                                onPressed: () => _controller.nextPage(),
                                icon: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Theme.of(context)
                                      .secondaryHeaderColor
                                      .withOpacity(0.7),
                                  size: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: operatorsLogo.map((url) {
                            int index = operatorsLogo.indexOf(url);
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Theme.of(context)
                                        .secondaryHeaderColor
                                        .withOpacity(0.9)
                                    : Theme.of(context)
                                        .secondaryHeaderColor
                                        .withOpacity(0.4),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color: Colors.white,
                              ),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () async {
                                            dynamic group =
                                                await ConnectToServer()
                                                    .getInternetPackagesGroup(
                                              mobileOperator:
                                                  operatorsNameDraw[_current],
                                            );
                                            if (group.length == 0) {
                                              group = await ConnectToServer()
                                                  .getInternetPackagesGroup(
                                                      mobileOperator: '');
                                            }
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      ShowInternetGroupPage(
                                                    mobileOperator:
                                                        operatorsNameDraw[
                                                            _current],
                                                    title: Languages.LANGUAGE[
                                                            snapshot.data]
                                                        ['internetTitle'],
                                                    lang: snapshot.data,
                                                    model: group,
                                                  ),
                                                  transitionDuration:
                                                      Duration(seconds: 0),
                                                ));
                                          },
                                          child: Container(
                                            width: sectionWidth,
                                            height: sectionHeight,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 0,
                                                      blurRadius: 2,
                                                      offset: Offset(0, 5)),
                                                ]),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                SvgPicture.asset(
                                                  'assets/mdi_globus.svg',
                                                  width: 46,
                                                  color: Theme.of(context)
                                                      .secondaryHeaderColor,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    Languages.LANGUAGE[snapshot
                                                        .data]['internetTitle'],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .secondaryHeaderColor,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            dynamic group =
                                                await ConnectToServer()
                                                    .getTariffPlansGroup(
                                              mobileOperator:
                                                  operatorsNameDraw[_current],
                                            );
                                            if (group.length == 0) {
                                              group = await ConnectToServer()
                                                  .getTariffPlansGroup(
                                                      mobileOperator: '');
                                            }
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      ShowTariffGroupPage(
                                                    mobileOperator:
                                                        operatorsNameDraw[
                                                            _current],
                                                    title: Languages.LANGUAGE[
                                                            snapshot.data]
                                                        ['tariffTitle'],
                                                    lang: snapshot.data,
                                                    model: group,
                                                  ),
                                                  transitionDuration:
                                                      Duration(seconds: 0),
                                                ));
                                          },
                                          child: Container(
                                            width: sectionWidth,
                                            height: sectionHeight,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 0,
                                                      blurRadius: 2,
                                                      offset: Offset(0, 5)),
                                                ]),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.sim_card,
                                                  size: 48,
                                                  color: Theme.of(context)
                                                      .secondaryHeaderColor,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  Languages.LANGUAGE[snapshot
                                                      .data]['tariffTitle'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .secondaryHeaderColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () async {
                                            dynamic group =
                                                await ConnectToServer()
                                                    .getMinutePackageGroup(
                                              mobileOperator:
                                                  operatorsNameDraw[_current],
                                            );
                                            if (group.length == 0) {
                                              group = await ConnectToServer()
                                                  .getMinutePackageGroup(
                                                      mobileOperator: '');
                                            }
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      ShowMinuteGroupPage(
                                                    mobileOperator:
                                                        operatorsNameDraw[
                                                            _current],
                                                    title: Languages.LANGUAGE[
                                                            snapshot.data]
                                                        ['minuteTitle'],
                                                    lang: snapshot.data,
                                                    model: group,
                                                  ),
                                                  transitionDuration:
                                                      Duration(seconds: 0),
                                                ));
                                          },
                                          child: Container(
                                            width: sectionWidth,
                                            height: sectionHeight,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 0,
                                                      blurRadius: 2,
                                                      offset: Offset(0, 5)),
                                                ]),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.access_time,
                                                  size: 48,
                                                  color: Theme.of(context)
                                                      .secondaryHeaderColor,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  Languages.LANGUAGE[snapshot
                                                      .data]['minuteTitle'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .secondaryHeaderColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            dynamic group =
                                                await ConnectToServer()
                                                    .getMessagePackageGroup(
                                              mobileOperator:
                                                  operatorsNameDraw[_current],
                                            );
                                            if (group.length == 0) {
                                              group = await ConnectToServer()
                                                  .getMessagePackageGroup(
                                                      mobileOperator: '');
                                            }
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      ShowMessageGroupPage(
                                                    mobileOperator:
                                                        operatorsNameDraw[
                                                            _current],
                                                    title: Languages.LANGUAGE[
                                                            snapshot.data]
                                                        ['smsTitle'],
                                                    lang: snapshot.data,
                                                    model: group,
                                                  ),
                                                  transitionDuration:
                                                      Duration(seconds: 0),
                                                ));
                                          },
                                          child: Container(
                                            width: sectionWidth,
                                            height: sectionHeight,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 0,
                                                      blurRadius: 2,
                                                      offset: Offset(0, 5)),
                                                ]),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.email,
                                                  size: 48,
                                                  color: Theme.of(context)
                                                      .secondaryHeaderColor,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  Languages.LANGUAGE[snapshot
                                                      .data]['smsTitle'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .secondaryHeaderColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () async {
                                            dynamic group =
                                                await ConnectToServer()
                                                    .getUssdCodesGroup(
                                              mobileOperator:
                                                  operatorsNameDraw[_current],
                                            );
                                            if (group.length == 0) {
                                              group = await ConnectToServer()
                                                  .getUssdCodesGroup(
                                                      mobileOperator: '');
                                            }
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      ShowUssdGroupPage(
                                                    mobileOperator:
                                                        operatorsNameDraw[
                                                            _current],
                                                    title: Languages.LANGUAGE[
                                                            snapshot.data]
                                                        ['ussdTitle'],
                                                    lang: snapshot.data,
                                                    model: group,
                                                  ),
                                                  transitionDuration:
                                                      Duration(seconds: 0),
                                                ));
                                          },
                                          child: Container(
                                            width: sectionWidth,
                                            height: sectionHeight,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 0,
                                                      blurRadius: 2,
                                                      offset: Offset(0, 5)),
                                                ]),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.dialpad,
                                                  size: 48,
                                                  color: Theme.of(context)
                                                      .secondaryHeaderColor,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  Languages.LANGUAGE[snapshot
                                                      .data]['ussdTitle'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .secondaryHeaderColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            dynamic group =
                                                await ConnectToServer()
                                                    .getServiceGroup(
                                              mobileOperator:
                                                  operatorsNameDraw[_current],
                                            );
                                            if (group.length == 0) {
                                              group = await ConnectToServer()
                                                  .getServiceGroup(
                                                      mobileOperator: '');
                                            }
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      ShowServiceGroupPage(
                                                    mobileOperator:
                                                        operatorsNameDraw[
                                                            _current],
                                                    title: Languages.LANGUAGE[
                                                            snapshot.data]
                                                        ['servicesTitle'],
                                                    lang: snapshot.data,
                                                    model: group,
                                                  ),
                                                  transitionDuration:
                                                      Duration(seconds: 0),
                                                ));
                                          },
                                          child: Container(
                                            width: sectionWidth,
                                            height: sectionHeight,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 0,
                                                      blurRadius: 2,
                                                      offset: Offset(0, 5)),
                                                ]),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.phonelink_setup,
                                                  size: 48,
                                                  color: Theme.of(context)
                                                      .secondaryHeaderColor,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  Languages.LANGUAGE[snapshot
                                                      .data]['servicesTitle'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .secondaryHeaderColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: Theme.of(context).primaryColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Flexible(
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      launch("tel:" +
                                          Uri.encodeComponent(specialUssd[
                                              operatorsNameDraw[_current]][0]));
                                    },
                                    child: Icon(
                                      Icons.wifi_tethering,
                                      color: Theme.of(context)
                                          .secondaryHeaderColor
                                          .withOpacity(0.7),
                                      size: 24.0,
                                    ),
                                    shape: CircleBorder(),
                                  ),
                                ),
                                Flexible(
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      launch("tel:" +
                                          Uri.encodeComponent(specialUssd[
                                              operatorsNameDraw[_current]][1]));
                                    },
                                    child: Icon(
                                      Icons.monetization_on,
                                      color: Theme.of(context)
                                          .secondaryHeaderColor
                                          .withOpacity(0.7),
                                      size: 24.0,
                                    ),
                                    shape: CircleBorder(),
                                  ),
                                ),
                                Flexible(
                                  child: RawMaterialButton(
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.home,
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      size: 35.0,
                                    ),
                                    shape: CircleBorder(),
                                  ),
                                ),
                                Flexible(
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      launch("tel:" +
                                          Uri.encodeComponent(specialUssd[
                                              operatorsNameDraw[_current]][2]));
                                    },
                                    child: Icon(
                                      Icons.headset_mic,
                                      color: Theme.of(context)
                                          .secondaryHeaderColor
                                          .withOpacity(0.7),
                                      size: 24.0,
                                    ),
                                    shape: CircleBorder(),
                                  ),
                                ),
                                Flexible(
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      launch("tel:" +
                                          Uri.encodeComponent(specialUssd[
                                              operatorsNameDraw[_current]][3]));
                                    },
                                    child: Icon(
                                      Icons.access_time,
                                      color: Theme.of(context)
                                          .secondaryHeaderColor
                                          .withOpacity(0.7),
                                      size: 24.0,
                                    ),
                                    shape: CircleBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          return Scaffold(
            body: Center(
              child: Text("Yuklanmoqda..."),
            ),
          );
        }
      },
    );
  }
}
