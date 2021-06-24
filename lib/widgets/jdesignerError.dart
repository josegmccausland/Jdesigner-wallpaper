import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JDError extends StatelessWidget {
  final String title, subtitle, path, buttonText;
  final Function onTap;
  const JDError({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.path,
    @required this.onTap,
    this.buttonText = 'Try again',
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
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 35)),
            SizedBox(height: 5),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 20)),
            SizedBox(height: 5),
            new FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
              ),
                color: Colors.black87,
                child: Text(
                  buttonText,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                  ),
                ),
                onPressed: onTap)
          ],
        ),
      ),
    );
  }
}
