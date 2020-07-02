import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class NavPage extends StatelessWidget {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Home(),
      ],
    );
  }
}
