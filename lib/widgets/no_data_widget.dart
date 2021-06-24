import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoDataJd extends StatelessWidget {
  final String title, subtitle, path;

  const NoDataJd({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(path),
                fit: BoxFit.contain,
              )),
            ),
            SizedBox(height: 3),
            Text(title,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
            SizedBox(height: 5),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
