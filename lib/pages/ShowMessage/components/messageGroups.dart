import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ussd/plugin/Languages.dart';
import 'package:mobile_ussd/database/models/message/MessagePackageModel.dart';
import 'package:mobile_ussd/pages/ShowMessage/components/ShowMessageDetailsPage.dart';
import 'package:url_launcher/url_launcher.dart';

class MessagePackageList extends StatefulWidget {
  final List<MessagePackageModel> packageModels;
  final String lang;
  final int groupId;
  final Color primaryColor;
  final BuildContext parentContext;

  MessagePackageList(
      {Key key,
      this.lang,
      this.packageModels,
      this.groupId,
      this.primaryColor,
      this.parentContext})
      : super(key: key);

  @override
  _MessagePackageListState createState() => _MessagePackageListState();
}

class _MessagePackageListState extends State<MessagePackageList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> tariffPlanItems() {
      List<Widget> list = [];
      for (var p in widget.packageModels) {
        if (p.messagePackagesGroup == widget.groupId) {
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
                              p.name,
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
                                            ShowMessageDetailsPage(
                                          lang: widget.lang,
                                          model: p,
                                          primaryColor: widget.primaryColor,
                                        ),
                                        transitionDuration:
                                            Duration(seconds: 0),
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
                            Container(
                                child: Text(
                              Languages.LANGUAGE[widget.lang]['ussdText'] +
                                  p.shiftCode,
                              style: TextStyle(
                                  color: widget.primaryColor,
                                  fontWeight: FontWeight.bold),
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
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          p.fieldATitle,
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
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          p.fieldAValue,
                                          maxLines: 3,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          p.fieldBTitle,
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
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          p.fieldBValue,
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
