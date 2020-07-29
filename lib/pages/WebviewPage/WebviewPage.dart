import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  final String url;
  final String title;

  WebviewPage({Key key, this.title, this.url}) : super(key: key);

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  @override
  Widget build(BuildContext context) {
    Completer<WebViewController> _controller = Completer<WebViewController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
