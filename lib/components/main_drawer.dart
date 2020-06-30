import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: LayoutBuilder(
        builder: (ctx, cnt) {
          return Container(
            height: cnt.maxHeight,
            width: cnt.maxWidth,
            child: Column(
              children: <Widget>[
                Container(
                  height: cnt.maxHeight * 0.2,
                  width: cnt.maxWidth,
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: cnt.maxWidth * 0.1),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Olá visitante',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Minha Conta',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: cnt.maxHeight * 0.8,
                  width: cnt.maxWidth,
                  child: Column(
                    children: <Widget>[],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
