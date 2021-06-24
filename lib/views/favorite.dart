import 'package:flutter/material.dart';
import 'package:jdesigner/database/db.dart';
import 'package:jdesigner/models/wallapaper_model.dart';
import 'package:jdesigner/widgets/widgets.dart';

class FavoriteView extends StatefulWidget {
  FavoriteView({Key key}) : super(key: key);

  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final dbJdeigner = DatabaseJd.instance;
  List<WallpaperModel> items = new List();
  @override
  void initState() {
    super.initState();
    dbJdeigner.queryAllRows().then((row) {
      setState(() {
        row.forEach((row) => items.add(WallpaperModel.fromMap(row)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? Center(
            child: NoDataJd(
              title: 'No Favourites yet',
              subtitle: 'Start adding to your Favourites by selecting the Add icon',
              path: 'assets/images/2.png',
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                WallpaperGrid(
                  data: items,
                   isFav: true
                )
              ],
            ),
          );
  }
}
