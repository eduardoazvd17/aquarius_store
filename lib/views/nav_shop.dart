import 'package:flutter/material.dart';

class NavShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, cnt) {
        return Container(
          height: cnt.maxHeight,
          width: cnt.maxWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          child: Container(),
        );
      },
    );
  }
}
