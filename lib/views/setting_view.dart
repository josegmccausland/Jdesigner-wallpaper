import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jdesigner/constants/constants.dart';
import 'package:jdesigner/widgets/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingView extends StatefulWidget {
  SettingView({Key key}) : super(key: key);

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  void initState() {
    super.initState();
  }

  void clearCache() async {
    try {
      await DefaultCacheManager().emptyCache();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          SettingWidget(
            title: 'Storage',
            children: [
              SettingTile(
                title: 'Clear Cache',
                icon: FontAwesomeIcons.memory,
                subtitle: '',
                onTap: () async {
                  if (await showConfirmationDialog(context, 'Are you sure?',
                      'Are you sure you want to clear cache?')) {
                    clearCache();
                  }
                },
              ),
            ],
          ),
          SettingWidget(
            title: 'Help',
            children: [
              SettingTile(
                icon: FontAwesomeIcons.user,
                title: 'Contact us',
                subtitle: 'Questions ? Need help ?',
                onTap: () {
                  // launch(reportBug);
                },
              ),
              SettingTile(
                icon: Icons.text_snippet,
                title: 'Terms and Privacy Policy',
                onTap: () {
                  launch(privacyUrl);
                },
              ),
              SettingTile(
                icon: Icons.info_outline,
                title: 'Note',
                onTap: () {
                  // launch(privacyUrl);
                },
              ),
            ],
          ),
          SettingWidget(
            title: 'Support Development',
            children: <Widget>[
              SettingTile(
                icon: Icons.share,
                title: 'Share',
                subtitle: 'Share this app with your friends.',
                onTap: () {
                  Share.share(shareStr);
                },
              ),
              SettingTile(
                icon: FontAwesomeIcons.star,
                title: 'Rate the app',
                subtitle: 'Rate the app on Google Play.',
                onTap: () {
                  launch(appUrl);
                },
              ),
              SettingTile(
                icon: FontAwesomeIcons.bug,
                title: 'Report a bug',
                onTap: () {
                  launch(reportBug);
                },
              )
            ],
          ),
          SizedBox(height: 30),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('from', style: TextStyle(color: Colors.black)),
                Text('BUCKTHORN',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
