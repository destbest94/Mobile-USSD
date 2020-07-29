import 'package:flutter/material.dart';
import 'package:mobile_ussd/plugin/Languages.dart';
import 'package:mobile_ussd/pages/ShowNews/components/ShowNewsDetailsPage.dart';
import 'package:mobile_ussd/pages/ShowNews/components/newsGroups.dart';

class ShowNewsGroupPage extends StatefulWidget {
  final dynamic model;
  final String title;
  final String mobileOperator;
  final String lang;

  ShowNewsGroupPage(
      {Key key,
      this.mobileOperator,
      this.title,
      this.lang,
      @required this.model})
      : super(key: key);

  @override
  _ShowNewsGroupPageState createState() => _ShowNewsGroupPageState();
}

class _ShowNewsGroupPageState extends State<ShowNewsGroupPage> {
  List tabs() {
    List<Widget> list = [];
    for (var m in widget.model) {
      list.add(Container(
        child: Tab(
          child: Text(
            m.title,
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

  Future<Widget> tabBarView() async {
    Widget list = NewsList(
      packageModels: widget.model,
      primaryColor: Theme.of(context).primaryColor,
      parentContext: context,
    );
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        iconTheme: IconThemeData(color: Theme.of(context).secondaryHeaderColor),
      ),
      body: widget.model.length == 0
          ? Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).secondaryHeaderColor,
                child: Text(
                  Languages.LANGUAGE[widget.lang]['errorBtn'],
                ),
              ),
            )
          : Container(
              child: ListView.builder(
              itemCount: widget.model.length,
              itemBuilder: (context, i) {
                return Container(
                  margin:
                      EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 10),
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black12))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    widget.model[i].title,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                    icon: Icon(Icons.info_outline),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                ShowNewseDetailsPage(
                                              model: widget.model[i],
                                              primaryColor: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            transitionDuration:
                                                Duration(seconds: 0),
                                          ));
                                    }),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    Languages.LANGUAGE[widget.lang]
                                            ['discriptionShort'] +
                                        widget.model[i].short,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )),
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Text(
                                            "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Text(
                                            widget.model[i].date,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
    );
  }
}
