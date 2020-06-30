import 'package:flutter/material.dart';

class ShopTitle extends StatelessWidget {
  final String title;
  ShopTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.4),
          child: Divider(
            thickness: 5,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
