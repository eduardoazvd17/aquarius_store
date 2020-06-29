import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  final int pageIndex;
  final Function changePage;
  MainDrawer({
    this.pageIndex,
    this.changePage,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, cnt) {
            return Column(
              children: <Widget>[
                Container(
                  height: cnt.maxHeight * 0.2,
                  width: cnt.maxWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Aquarius ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Text(
                                  'Store',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  textColor: Theme.of(context).primaryColor,
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.person),
                                      Text(' Entrar'),
                                    ],
                                  ),
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  textColor: Theme.of(context).accentColor,
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.person_add),
                                      Text(' Cadastrar-se'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
                Container(
                  height: cnt.maxHeight * 0.8,
                  width: cnt.maxWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          ListTile(
                            selected: pageIndex == 0,
                            onTap: () => {
                              changePage(0),
                              Get.close(1),
                            },
                            leading: Icon(Icons.home),
                            title: Text('Inicio'),
                          ),
                          Divider(),
                          ListTile(
                            selected: pageIndex == 1,
                            onTap: () => {
                              changePage(1),
                              Get.close(1),
                            },
                            leading: Icon(Icons.shop),
                            title: Text('Loja'),
                          ),
                          Divider(),
                          ListTile(
                            selected: pageIndex == 2,
                            onTap: () => {
                              changePage(2),
                              Get.close(1),
                            },
                            leading: Icon(Icons.favorite),
                            title: Text('Favoritos'),
                          ),
                          Divider(),
                        ],
                      ),
                      ListTile(
                        trailing: Icon(
                          Icons.exit_to_app,
                          color: Theme.of(context).errorColor,
                        ),
                        title: Text('Finalizar Sessão'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
