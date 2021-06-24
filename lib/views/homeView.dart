import 'package:flutter/material.dart';
import 'package:jdesigner/widgets/widgets.dart';

class HomeView extends StatefulWidget {
  final data;
  HomeView({Key key, @required this.data}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [WallpaperGrid(data:widget.data)],
      ),
    );
  }
}
