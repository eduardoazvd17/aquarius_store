import 'package:aquariusstore/controllers/nav_controller.dart';
import 'package:aquariusstore/controllers/user_controller.dart';
import 'package:aquariusstore/components/drawer_tile.dart';
import 'package:aquariusstore/views/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  final NavController navController = Get.find<NavController>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: LayoutBuilder(
        builder: (ctx, cnt) {
          return Container(
            height: cnt.maxHeight,
            width: cnt.maxWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor,
                  Colors.blue[50],
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: cnt.maxHeight * 0.3,
                  width: cnt.maxWidth,
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
                            !userController.isLogged()
                                ? 'Olá visitante'
                                : 'Olá ${userController.user.value.fullName.split(' ').first}.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: cnt.maxWidth * 0.1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (!userController.isLogged()) {
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
                                          navController.setPage(0);
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
                              !userController.isLogged()
                                  ? 'Entre ou cadastre-se >'
                                  : 'Finalizar sessão',
                              style: TextStyle(
                                fontSize: cnt.maxWidth * 0.069,
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
                  height: cnt.maxHeight * 0.7,
                  width: cnt.maxWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
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
                        Obx(
                          () => !userController.isLogged()
                              ? Container()
                              : DrawerTile(
                                  iconData: Icons.playlist_add_check,
                                  title: 'Meus Pedidos',
                                  page: 2,
                                ),
                        ),
                        DrawerTile(
                          iconData: Icons.location_on,
                          title: 'Lojas',
                          page: 3,
                        ),
                        Obx(
                          () => !userController.isLogged()
                              ? Container()
                              : !userController.user.value.isAdm
                                  ? Container()
                                  : Column(
                                      children: <Widget>[
                                        Divider(),
                                        Text(
                                          'Administração',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Divider(),
                                        DrawerTile(
                                          iconData: Icons.category,
                                          title: 'Destaques',
                                          page: 4,
                                        ),
                                        DrawerTile(
                                          iconData: Icons.people,
                                          title: 'Usuários',
                                          page: 5,
                                        ),
                                        DrawerTile(
                                          iconData: Icons.shop_two,
                                          title: 'Produtos',
                                          page: 6,
                                        ),
                                        DrawerTile(
                                          iconData: Icons.featured_play_list,
                                          title: 'Pedidos',
                                          page: 7,
                                        ),
                                      ],
                                    ),
                        ),
                      ],
                    ),
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
