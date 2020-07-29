import 'package:flutter/material.dart';
import 'package:mobile_ussd/database/models/news/NewsModel.dart';

class ShowNewseDetailsPage extends StatefulWidget {
  final NewsModel model;
  final Color primaryColor;
  ShowNewseDetailsPage({Key key, this.model, this.primaryColor})
      : super(key: key);

  @override
  _ShowNewseDetailsPageState createState() => _ShowNewseDetailsPageState();
}

class _ShowNewseDetailsPageState extends State<ShowNewseDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: widget.primaryColor,
          title: Text(widget.model.title,
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        child: Text(
                      widget.model.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: widget.primaryColor,
                          fontWeight: FontWeight.bold),
                    )),
                    Container(
                        child: Text(
                      widget.model.date,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black38,),
                    )),
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Column(
                        children: <Widget>[
                          Text(widget.model.full),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
