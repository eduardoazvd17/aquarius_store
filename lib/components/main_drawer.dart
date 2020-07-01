import 'package:aquariusstore/views/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Olá visitante',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.to(Login()),
                          child: Text(
                            'Entre ou Cadastre-se',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: cnt.maxHeight * 0.8,
                  width: cnt.maxWidth,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Início'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.shop),
                        title: Text('Produtos'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Minha Conta'),
                      ),
                      Divider(),
                    ],
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
