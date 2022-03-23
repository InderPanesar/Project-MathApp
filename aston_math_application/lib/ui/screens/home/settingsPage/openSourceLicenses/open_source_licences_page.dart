import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


class OpenSourceLicencePage extends StatefulWidget {
  @override
  OpenSourceLicencePageState createState() {
    return OpenSourceLicencePageState();
  }
}

class OpenSourceLicencePageState extends State<OpenSourceLicencePage> {
  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Open Source Licenses"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'about:blank',
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
          _loadHtmlFromAssets();
        },
        navigationDelegate: (NavigationRequest request) {
          _launchURL(request.url);
          return NavigationDecision.prevent;
        },
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/text/licenses.html');
    _controller?.loadUrl( Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());

  }
}