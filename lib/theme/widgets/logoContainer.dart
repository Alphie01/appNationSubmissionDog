import 'package:appnationdoggy/theme/sizeconfig.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: paddingHorizontal, bottom: paddingHorizontal / 2),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(paddingHorizontal),
            image: DecorationImage(
              image: AssetImage('assets/images/appNationLogo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
