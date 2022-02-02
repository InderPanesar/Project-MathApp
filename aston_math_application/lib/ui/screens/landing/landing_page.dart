import 'package:aston_math_application/ui/screens/authentication/login/login_page.dart';
import 'package:aston_math_application/ui/screens/authentication/register/register_page.dart';
import 'package:aston_math_application/ui/screens/landing/page_view_pages.dart';
import 'package:aston_math_application/util/styles/ButtonStyles.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';



class LandingPageWidget extends StatelessWidget {

  void onSignInPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPageWidget()),
    );
  }

  void onRegisterPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPageWidget()),
    );
  }


  @override
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction: 0.8, keepPage: true);
    List<Widget> pages = PageViewPages.getPages();

    return Container(
      color: Color.fromRGBO(219, 233, 247, 1),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 120),
            color: Colors.black,
            height: 250,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [


              SizedBox(
                height: 80,
                child: PageView.builder(
                  controller: controller,
                  // itemCount: pages.length,
                  itemBuilder: (_, index) {
                    return pages[index! % pages.length];
                  },
                ),
              ),




              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: TextButton(
                        child: Text('signin').tr(),
                        style: buttonMainStyle,
                        onPressed: () => onSignInPressed(context),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    ),
                    Container(
                      child: TextButton(
                        child: Text('Register'),
                        style: secondaryMainStyle,
                        onPressed: () => onRegisterPressed(context),
                      ),
                      margin: EdgeInsets.fromLTRB(16, 4, 16, 37),
                    )
                  ],
                ),
              )
            ],
          )



        ],
      )
    );
  }
}
