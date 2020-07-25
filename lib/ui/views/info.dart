import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scan_shot/core/services/launch_url.dart';
import 'package:url_launcher/url_launcher.dart';

var mainText = new RichText(
  textAlign: TextAlign.center,
  text: new TextSpan(
    style: new TextStyle(
      fontSize: 20.0,
      letterSpacing: 1,
      color: const Color(0xff212121),
      fontWeight: FontWeight.bold,
    ),
    children: <TextSpan>[
      new TextSpan(
        text: 'Saurabh Raj',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.black87,
        ),
      ),
      new TextSpan(
        text: '\nFlutter/Web Developer',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
          color: Colors.black54,
        ),
      ),
    ],
  ),
);

var midText = Text(
  "For suggestions and requests please feel free to email me !",
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
  textAlign: TextAlign.center,
);

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final String email = "saurabhraj042@gmail.com";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Info",
          style: TextStyle(
            fontSize: 25.0,
            letterSpacing: 1,
            color: const Color(0xffFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 20,
        centerTitle: true,
        backgroundColor: const Color(0xff512DA8),
      ),
      body: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        color: const Color(0xff673AB7),
        child: SizedBox(
          height: height * 0.70,
          width: width * 0.90,
          child: Card(
            elevation: 20,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: width * 0.70,
                  child: Image.network(
                      'https://img1.hotstarext.com/image/upload/f_auto,t_hcdl/sources/r1/cms/prod/9539/649539-h'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: mainText,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: midText,
                ),
                SizedBox(
                  width: width * 0.40,
                  child: RaisedButton(
                    elevation: 10,
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: Colors.white,
                    onPressed: () => sendEmail(email),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.googlePlus,
                          //size: ,
                          color: Color(0xffFF5252),
                        ),
                        SizedBox(width: 5),
                        Text("Email me !")
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.40,
                  child: RaisedButton(
                    elevation: 10,
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: Colors.white,
                    onPressed: () =>
                        launchURL(url: 'https://github.com/saurabhraj042'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.github,
                          //size: ,
                          color: Colors.black,
                        ),
                        SizedBox(width: 5),
                        Text("Github Repo ")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void sendEmail(String email) => launch("mailto:$email");
