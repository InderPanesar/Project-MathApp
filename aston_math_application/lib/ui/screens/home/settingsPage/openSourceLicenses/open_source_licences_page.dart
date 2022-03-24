import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


class OpenSourceLicencePage extends StatefulWidget {
  @override
  OpenSourceLicencePageState createState() {
    return OpenSourceLicencePageState();
  }
}

class OpenSourceLicencePageState extends State<OpenSourceLicencePage> {
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
        //Where the open source licenses are stored as local html doesn't work on iOS
        initialUrl: 'https://inderpanesar.github.io',
        navigationDelegate: (NavigationRequest request) {
          if(request.url == "https://inderpanesar.github.io/") {
            return NavigationDecision.navigate;
          }
          else {
            //Launch Any URL links in a external browser.
            _launchURL(request.url);
            return NavigationDecision.prevent;
          }
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



}