import 'package:flutter/material.dart';
import 'package:mobile_ussd/plugin/Languages.dart';
import 'package:mobile_ussd/database/models/minute/MinutePackageModel.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowMinuteDetailsPage extends StatefulWidget {
  final MinutePackageModel model;
  final Color primaryColor;
  final String lang;

  ShowMinuteDetailsPage({Key key, this.lang, this.model, this.primaryColor})
      : super(key: key);

  @override
  _ShowMinuteDetailsPageState createState() => _ShowMinuteDetailsPageState();
}

class _ShowMinuteDetailsPageState extends State<ShowMinuteDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: widget.primaryColor,
          title: Text(widget.model.name,
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black12))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.model.name,
                      style: TextStyle(
                          color: widget.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        child: Text(
                      Languages.LANGUAGE[widget.lang]['ussdText'] +
                          widget.model.shiftCode,
                      style: TextStyle(
                          color: widget.primaryColor,
                          fontWeight: FontWeight.bold),
                    )),
                    Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  widget.model.fieldATitle,
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
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  widget.model.fieldAValue,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  widget.model.fieldBTitle,
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
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  widget.model.fieldBValue,
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
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Column(
                        children: <Widget>[
                          Text(widget.model.description),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: widget.primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: Offset(0, 5)),
                        ]),
                    child: Center(
                      child: Text(
                        Languages.LANGUAGE[widget.lang]['activateBtn'],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    launch(
                        "tel:" + Uri.encodeComponent(widget.model.shiftCode));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
