import 'package:aquariusstore/controllers/user_controller.dart';
import 'package:aquariusstore/components/drawer_tile.dart';
import 'package:aquariusstore/views/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
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
                  height: cnt.maxHeight * 0.234,
                  width: cnt.maxWidth,
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: cnt.maxWidth * 0.1),
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            userController.user == null
                                ? 'Olá visitante'
                                : 'Olá ${userController.user.value.fullName.split(' ').first}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (userController.user == null) {
                                Get.to(Login());
                              } else {
                                Get.dialog(
                                  AlertDialog(
                                    title: Text('Finalizar Sessão'),
                                    content: Text(
                                        'Deseja realmente sair desta conta?'),
                                    actions: <Widget>[
                                      FlatButton(
                                        textColor:
                                            Theme.of(context).accentColor,
                                        onPressed: () {
                                          userController.setUser(null);
                                          Get.close(1);
                                        },
                                        child: Text('Sim'),
                                      ),
                                      FlatButton(
                                        textColor:
                                            Theme.of(context).accentColor,
                                        onPressed: () {
                                          Get.close(1);
                                        },
                                        child: Text('Não'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text(
                              userController.user == null
                                  ? 'Entre ou Cadastre-se'
                                  : 'Finalizar Sessão',
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
                ),
                Container(
                  height: cnt.maxHeight * 0.766,
                  width: cnt.maxWidth,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      DrawerTile(
                        iconData: Icons.home,
                        title: 'Início',
                        page: 0,
                      ),
                      DrawerTile(
                        iconData: Icons.list,
                        title: 'Produtos',
                        page: 1,
                      ),
                      DrawerTile(
                        iconData: Icons.playlist_add_check,
                        title: 'Meus Pedidos',
                        page: 2,
                      ),
                      DrawerTile(
                        iconData: Icons.location_on,
                        title: 'Lojas',
                        page: 3,
                      ),
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
