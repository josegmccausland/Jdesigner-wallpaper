import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jdesigner/bloc/wallpaper_bloc.dart';
import 'package:jdesigner/repository/wallpaper_repository.dart';
import 'package:jdesigner/screens/homeScreen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jdesigner Wallpaper',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => WallpaperBloc(
          wallpaperRepository: WallpaperImplements(),
        ),
        child: HomeScreen(),
      ),
      theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),
    );
  }
}
