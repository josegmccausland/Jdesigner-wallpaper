import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jdesigner/constants/const_color.dart';
import 'package:jdesigner/pages/tag_selected_page.dart';

class TagGrid extends StatelessWidget {
  final tag, data;
  const TagGrid({Key key, this.tag, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tag.length != 0
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2.1),
              controller: ScrollController(),
              shrinkWrap: true,
              itemCount: tag.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TagSelectedPage(
                            tag: tag[index],
                            data: data,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: index < cardColors.length
                            ? cardColors[index]
                            : cardColors[index % cardColors.length],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          '${tag[index]}',
                          style: GoogleFonts.oswald(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16)
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : Container(
            child: Text('dude no tags'),
          );
  }
}
