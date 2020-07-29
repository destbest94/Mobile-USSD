import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ussd/plugin/Languages.dart';
import 'package:mobile_ussd/database/models/ussd/UssdCodeModel.dart';
import 'package:url_launcher/url_launcher.dart';

class UssdCodeList extends StatefulWidget {
  final List<UssdCodeModel> packageModels;
  final String lang;
  final int groupId;
  final Color primaryColor;
  final BuildContext parentContext;

  UssdCodeList(
      {Key key,
      this.lang,
      this.packageModels,
      this.groupId,
      this.primaryColor,
      this.parentContext})
      : super(key: key);

  @override
  _UssdCodeListState createState() => _UssdCodeListState();
}

class _UssdCodeListState extends State<UssdCodeList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> tariffPlanItems() {
      List<Widget> list = [];
      for (var p in widget.packageModels) {
        if (p.ussdCodesGroup == widget.groupId) {
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
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                p.name,
                                style: TextStyle(
                                    color: widget.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
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
                            Container(
                                child: Text(
                              Languages.LANGUAGE[widget.lang]['ussdText'] +
                                  p.shiftCode,
                              style: TextStyle(
                                  color: widget.primaryColor,
                                  fontWeight: FontWeight.bold),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 3,
                  child: InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 30,
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
                      launch("tel:" + Uri.encodeComponent(p.shiftCode));
                    },
                  )),
            ],
          ));
        }
      }

      return list;
    }

    return ListView(
      children: tariffPlanItems(),
    );
  }
}
