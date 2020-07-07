import 'package:aquariusstore/components/main_drawer.dart';
import 'package:flutter/material.dart';

class GenUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(child: Text('Gerenciamento de Usuários')),
      ),
      drawer: MainDrawer(),
      body: LayoutBuilder(
        builder: (ctx, cnt) {
          return Container();
        },
      ),
    );
  }
}
