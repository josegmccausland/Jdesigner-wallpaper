import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jdesigner/pages/image_view_page.dart';

class WallpaperGrid extends StatelessWidget {
  final data;
  final bool isFav;
  const WallpaperGrid({Key key, this.data, this.isFav = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data.length != 0
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: 6.0,
              mainAxisSpacing: 6.0,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                data.length,
                (index) {
                  return GridTile(
                    child: GestureDetector(
                      onTap: () {
                        //ImageViewPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageViewPage(
                              tag: '',
                              image: isFav
                                  ? data[index].image
                                  : data[index]['image'],
                            ),
                          ),
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl: isFav ? data[index].image : data[index]['image'],
                        errorWidget: (context, url, error) => Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(
                            child: Icon(Icons.error, color: Colors.black26),
                          ),
                        ),
                        placeholder: (context, url) => Center(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black87,
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.blue),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        : Container(
            child: Text('er'),
          );
  }
}
