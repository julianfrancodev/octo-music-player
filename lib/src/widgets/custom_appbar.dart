import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Row(
          children: [
            FaIcon(FontAwesomeIcons.chevronLeft),
            Spacer(),
            FaIcon(FontAwesomeIcons.commentAlt),
            SizedBox(
              width: 20,
            ),
            FaIcon(FontAwesomeIcons.headphonesAlt),
            SizedBox(
              width: 20,
            ),
            FaIcon(FontAwesomeIcons.externalLinkAlt),
          ],
        ),
      ),
    );
  }
}
