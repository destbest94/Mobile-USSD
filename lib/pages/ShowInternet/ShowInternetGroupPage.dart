import 'package:flutter/material.dart';
import 'package:mobile_ussd/plugin/Connection.dart';
import 'package:mobile_ussd/plugin/Languages.dart';
import 'package:mobile_ussd/database/models/internet/InternetPackageModel.dart';
import 'package:mobile_ussd/pages/ShowInternet/components/InternetGroups.dart';

class ShowInternetGroupPage extends StatefulWidget {
  final dynamic model;
  final String title;
  final String mobileOperator;
  final String lang;

  ShowInternetGroupPage(
      {Key key,
      this.mobileOperator,
      this.title,
      this.lang,
      @required this.model})
      : super(key: key);

  @override
  _ShowInternetGroupPageState createState() => _ShowInternetGroupPageState();
}

class _ShowInternetGroupPageState extends State<ShowInternetGroupPage> {
  List tabs() {
    List<Widget> list = [];
    for (var m in widget.model) {
      list.add(Container(
        child: Tab(
          child: Text(
            m.name,
            style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
          ),
        ),
      ));
    }

    if (list.length == 0) {
      list.add(Container(
        child: Tab(
          child: Text(
            Languages.LANGUAGE[widget.lang]['errorTitle'],
            style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
          ),
        ),
      ));
    }
    return list;
  }

  List<String> getGroupsId() {
    List<String> list = [];
    for (var m in widget.model) {
      list.add(m.id.toString());
    }
    return list;
  }

  Future<List<Widget>> tabBarView() async {
    List<InternetPackageModel> packageModels = await ConnectToServer()
        .getInternetPackage(
            mobileOperator: widget.mobileOperator, groupsId: getGroupsId());

    if (packageModels.length == 0) {
      packageModels = await ConnectToServer()
          .getInternetPackage(mobileOperator: '', groupsId: getGroupsId());
    }

    List<Widget> list = [];
    for (var m in widget.model) {
      list.add(
        InternetPackageList(
          lang: widget.lang,
          packageModels: packageModels,
          groupId: m.id,
          primaryColor: Theme.of(context).primaryColor,
          parentContext: context,
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: widget.model.length == 0 ? 1 : widget.model.length,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(widget.title,
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                  )),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              iconTheme:
                  IconThemeData(color: Theme.of(context).secondaryHeaderColor),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {},
                )
              ],
              bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  indicatorColor: Theme.of(context).secondaryHeaderColor,
                  tabs: tabs()),
            ),
            body: Container(
              child: widget.model.length == 0
                  ? Center(
                      child: RaisedButton(
                        onPressed: () {
                          ConnectToServer()
                              .downloadAll(anyway: true)
                              .then((value) => null);
                          Navigator.pop(context);
                        },
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).secondaryHeaderColor,
                        child: Text(
                          Languages.LANGUAGE[widget.lang]['errorBtn'],
                        ),
                      ),
                    )
                  : FutureBuilder(
                      future: tabBarView(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return TabBarView(
                            children: snapshot.data,
                          );
                        } else {
                          return Center(
                            child: Text(
                                Languages.LANGUAGE[widget.lang]['loadingText']),
                          );
                        }
                      }),
            ),
          )),
    );
  }
}
