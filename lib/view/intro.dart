import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pusatinformasi/model/intro.dart';
import 'package:pusatinformasi/utils/color_palette.dart';
import 'package:pusatinformasi/widgets/custom_flat_futton.dart';

import 'package:pusatinformasi/view/home.dart';

class IntroPage extends StatefulWidget {
  final SharedPreferences prefs;
  
  IntroPage({ this.prefs });
  
  @override
  _IntroPageState createState() => _IntroPageState();
}


class _IntroPageState extends State<IntroPage> {

  final List<Intro> introList = [
    Intro(
      image: "images/icon_search.png",
      title: "Temukan",
      description: "Ketahui berbagai informasi lokasi dan tempat-tempat terbaik yang ada di sekitar Probolinggo."
    ),
    Intro(
      image: "images/icon_hamburger.png",
      title: "Makanan",
      description: "Cari tempat makan dan hidangan terbaik yang ada di Probolinggo."
    ),
    Intro(
      image: "images/icon_otw.png",
      title: "Pesan",
      description: "Anda juga dapat memesan, mengantarkan barang paket anda dengan mudah."
    )
  ];


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Swiper.children(
        index: 0,
        autoplay: false,
        loop: false,
        pagination: SwiperPagination(
          margin: EdgeInsets.only(bottom: 20.0),
          builder: DotSwiperPaginationBuilder(
            color: ColorPalette.dotColor,
            activeColor: ColorPalette.dotActiveColor,
            size: 10.0,
            activeSize: 10.0
          )
        ),
        control: SwiperControl(
          iconNext: null,
          iconPrevious: null
        ),
        children: _buildPage(context)
      ),
    );
  }

  List<Widget> _buildPage(BuildContext context) {
    List<Widget> widgets = [];

    for (int i=0; i<introList.length; i++) {
      Intro intro = introList[i];
      widgets.add(
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height/6
          ),

          child: ListView(
            children: <Widget>[
              Image.asset(
                intro.image,
                height: MediaQuery.of(context).size.height/4.0
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height/12.0
                )
              ),

              Center(
                child: Text(
                  intro.title,
                  style: TextStyle(
                    color: ColorPalette.titleColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500
                  )
                )
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height/40.0
                )
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height/20.0
                ),
                child: Text(
                  intro.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPalette.descriptionColor,
                    fontSize: 15.0,
                    height: 1.5
                  )
                )
              )

            ],
          ),
        )
      );
    }

    widgets.add(
      new Container(
        color: Color.fromRGBO(212, 20, 15, 1.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.code,
                size: 125.0,
                color: Colors.white,
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 50.0, right: 15.0, left: 15.0),
                child: Text(
                  "Jump straight into the action.",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 24.0,
                    fontFamily: "NunitoSemiBold",
                  )
                )
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 20.0, right: 15.0, left: 15.0),
                child: CustomFlatButton(
                  title: "Get Started",
                  fontSize: 22,
                  textColor: Colors.white,
                  onPressed: () {
                    widget.prefs.setBool('seen', true);
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  splashColor: Colors.black12,
                  borderColor: Colors.white,
                  borderWidth: 2,
                  color: Color.fromRGBO(212, 20, 15, 1.0),
                )
              )
            ]
          )
        )
      )
    );

    return widgets;
  }
}