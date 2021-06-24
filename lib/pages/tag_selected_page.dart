import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jdesigner/widgets/widgets.dart';

class TagSelectedPage extends StatefulWidget {
  final String tag;
  final data;
  TagSelectedPage({Key key, @required this.tag, @required this.data})
      : super(key: key);

  @override
  _TagSelectedPageState createState() => _TagSelectedPageState();
}

class _TagSelectedPageState extends State<TagSelectedPage> {
  List tagWallpaper = [];

  @override
  void initState() {
    super.initState();
    tagWallpaper = getTagWallpaper(widget.tag, widget.data);
  }

  getTagWallpaper(tag, tagList) {
    var result = [];
    for (int i = 0; i < tagList.length; i++) {
      if (tagList[i]['tag'] == tag) {
        result.add(tagList[i]);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.tag,
          style: GoogleFonts.pacifico(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [WallpaperGrid(data: tagWallpaper)],
        ),
      ),
    );
  }
}
