import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:jdesigner/database/db.dart';
import 'package:jdesigner/widgets/widgets.dart';
import 'package:toast/toast.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:flutter/services.dart';

class ImageViewPage extends StatefulWidget {
  final tag, image;
  ImageViewPage({Key key, this.tag, this.image}) : super(key: key);

  @override
  _ImageViewPageState createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  final dbJdesigner = DatabaseJd.instance;
  bool _isliked = true;
  bool _dwdWall = true;
  bool _setWall = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    FirebaseAdMob.instance.initialize(
        appId: 'ca-app-pub-1356453008260262~1346959852'); //Admob Pub id here
    dataAlreadyExist();
  }

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    nonPersonalizedAds: true,
    keywords: <String>[
      'Football',
      'Soccer',
      'Serie A',
      'juventus',
      'Ronaldo',
      'Dybala'
    ],
  );
  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: 'ca-app-pub-1356453008260262/2143685134', // Interstital ID here
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print('inter $event');
      },
    );
  }

  void dataAlreadyExist() async {
    var result = await dbJdesigner.queryRowExist(widget.image);
    setState(() {
      _isliked = result.isNotEmpty ? false : true;
    });
  }

  Future<void> downloadWallpaper(BuildContext context) async {
    try {
      GallerySaver.saveImage(widget.image).then((value) {
        Toast.show('Downloaded', context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      });
      Navigator.pop(context);
      createInterstitialAd()
        ..load()
        ..show();
      setState(() {
        _dwdWall = !_dwdWall;
      });
    } catch (e) {
      Navigator.pop(context);
      createInterstitialAd()
        ..load()
        ..show();

      Toast.show('Error', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  Future<void> setWallpaperHome(BuildContext context) async {
    showLoading(context);
    try {
      var file = await DefaultCacheManager().getSingleFile(widget.image);
      var result = await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.HOME_SCREEN);
      print(result.toString());
      setState(() {
        _setWall = !_setWall;
      });
      Navigator.pop(context);
      createInterstitialAd()
        ..load()
        ..show();

      Toast.show('New wallpaper :)', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } catch (e) {
      Navigator.pop(context);
      createInterstitialAd()
        ..load()
        ..show();
      Toast.show('Error', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.network(
            widget.image,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomCenter,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    JDButton(
                      icon: _setWall
                          ? Icon(FontAwesomeIcons.image)
                          : Icon(FontAwesomeIcons.check),
                      action: _setWall
                          ? () async => setWallpaperHome(context)
                          : () {
                              Toast.show('Check your screen', context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                            },
                    ),
                    JDButton(
                      icon: _isliked
                          ? Icon(FontAwesomeIcons.heart)
                          : Icon(FontAwesomeIcons.solidHeart),
                      action: _isliked
                          ? () async {
                              setState(() => _isliked = !_isliked);
                              Map<String, dynamic> row = {
                                DatabaseJd.columnimage: widget.image,
                              };
                              await dbJdesigner.insert(row);
                            }
                          : () async {
                              setState(() => _isliked = !_isliked);
                              await dbJdesigner.deletebyWallpaper(widget.image);
                            },
                    ),
                    JDButton(
                      icon: _dwdWall
                          ? Icon(FontAwesomeIcons.download)
                          : Icon(FontAwesomeIcons.check),
                      action: _dwdWall
                          ? () async {
                              showLoading(context);

                              downloadWallpaper(context);
                            }
                          : () {
                              Toast.show('Already downloaded', context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                            },
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                )
              ]),
        ),
      ],
    ));
  }
}
