import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ussd/plugin/Languages.dart';
import 'package:mobile_ussd/database/models/news/NewsModel.dart';
import 'package:mobile_ussd/pages/ShowNews/components/ShowNewsDetailsPage.dart';

class NewsList extends StatefulWidget {
  final List<NewsModel> packageModels;
  final String lang;
  final Color primaryColor;
  final BuildContext parentContext;

  NewsList(
      {Key key,
      this.lang,
      this.packageModels,
      this.primaryColor,
      this.parentContext})
      : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> tariffPlanItems() {
      List<Widget> list = [];
      for (var p in widget.packageModels) {
        print(p.title);
        list.add(Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                          Text(
                            p.title,
                            style: TextStyle(
                                color: widget.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              icon: Icon(Icons.info_outline),
                              onPressed: () {
                                Navigator.push(
                                    widget.parentContext,
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          ShowNewseDetailsPage(
                                        model: p,
                                        primaryColor: widget.primaryColor,
                                      ),
                                      transitionDuration: Duration(seconds: 0),
                                    ));
                              })
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                                child: Text(
                              Languages.LANGUAGE[widget.lang]
                                      ['discriptionShort'] +
                                  p.short,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                  color: widget.primaryColor,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
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
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        p.date,
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
                          Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        p.title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        p.title,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
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
            ),
          ],
        ));
      }

      return list;
    }

    return ListView(
      children: tariffPlanItems(),
    );
  }
}
