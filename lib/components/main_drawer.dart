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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Image.asset(
                              "assets/images/banner.png",
                              alignment: Alignment.center,
                            ),
                          ),
                          Text(
                            userController.user.value == null
                                ? 'Olá visitante'
                                : 'Olá ${userController.user.value.fullName}.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (userController.user.value == null) {
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
                              userController.user.value == null
                                  ? 'Entre ou cadastre-se >'
                                  : 'Finalizar sessão',
                              style: TextStyle(
                                fontSize: 20,
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
                          () => userController.user.value == null
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
                          () => userController.user.value == null
                              ? Container()
                              : !userController.user.value.isAdm
                                  ? Container()
                                  : Column(
                                      children: <Widget>[
                                        Divider(),
                                        DrawerTile(
                                          iconData: Icons.settings,
                                          title: 'Configurações',
                                          page: 4,
                                        ),
                                        DrawerTile(
                                          iconData: Icons.settings_applications,
                                          title: 'Teste',
                                          page: 5,
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
