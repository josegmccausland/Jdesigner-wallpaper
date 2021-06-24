import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jdesigner/bloc/wallpaper_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jdesigner/bloc/wallpaper_event.dart';
import 'package:jdesigner/bloc/wallpaper_state.dart';
import 'package:jdesigner/views/views.dart';
import 'package:jdesigner/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  WallpaperBloc wallpaperBloc;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    wallpaperBlocFunction();
    _tabController = TabController(length: 4, vsync: this);
    _firebaseMessaging.configure(onLaunch: (message) async {
      print(message);
    }, onResume: (message) async {
      print(message);
    }, onMessage: (message) async {
      print(message);
    });
    _firebaseMessaging.getToken().then((value) {
      print(value);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> wallpaperBlocFunction() async {
    wallpaperBloc = BlocProvider.of<WallpaperBloc>(context);
    wallpaperBloc.add(FetchWallpaperEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'J Designer',
          style: GoogleFonts.pacifico(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            homeWallpaper(true),
            homeWallpaper(false),
            FavoriteView(),
            SettingView()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: TabBar(
          controller: _tabController,
          unselectedLabelColor: Colors.black45,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 0.0),
          ),
          labelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 15),
          tabs: [
            Tab(
              icon: Icon(FontAwesomeIcons.home),
            ),
            Tab(
              icon: Icon(FontAwesomeIcons.tags),
            ),
            Tab(
              icon: Icon(FontAwesomeIcons.solidHeart),
            ),
            Tab(
              icon: Icon(Icons.settings),
            )
          ],
        ),
      ),
    );
  }

  Widget homeWallpaper(isHome) {
    return BlocBuilder<WallpaperBloc, WallpaperState>(
      builder: (context, state) {
        if (state is WallpaperInitialState) {
          return JDLoader();
        }
        if (state is WallpaperLoadingState) {
          return JDLoader();
        }
        if (state is WallpaperLoadedState) {
          var data = state.data;
          return isHome
              ? HomeView(
                  data: data,
                )
              : TagView(
                  data: data,
                );
        }
        if (state is WallpaperErrorState) {
          return Center(
            child: JDError(
              title: 'Whoops!!',
              subtitle:
                  'You are not connected to internet. Please check your connection.',
              path: 'assets/images/2.png',
              onTap: wallpaperBlocFunction,
            ),
          );
        } else {
          return Center(
            child: JDError(
              title: 'Aaaah! Something went wrong',
              subtitle:
                  'Don\'t worry, it\'s not you - it\'s us. Sorry about that.',
              path: 'assets/images/2.png',
              onTap: wallpaperBlocFunction,
            ),
          );
        }
      },
    );
  }
}
