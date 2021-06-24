import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jdesigner/widgets/widgets.dart';

class TagView extends StatefulWidget {
  final data;
  TagView({Key key, @required this.data}) : super(key: key);

  @override
  _TagViewState createState() => _TagViewState();
}

class _TagViewState extends State<TagView> {
  List tag = [];
  @override
  void initState() {
    super.initState();
    tag = createTagFunction(widget.data);
  }

  createTagFunction(tags) {
    var result = [];
    for (int i = 0; i < tags.length; i++) {
      if (!result.contains(tags[i]['tag'])) {
        result.add(tags[i]['tag']);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Text(
              'Categories',
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            height: 30.0,
          ),
          TagGrid(tag: tag, data: widget.data)
        ],
      ),
    );
  }
}
