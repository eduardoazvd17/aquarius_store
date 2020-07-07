import 'package:aquariusstore/components/empty_list_message.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text('Adicionar Produto'),
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (ctx, cnt) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 250,
                    color: Theme.of(context).primaryColor,
                    child: EmptyListMessage('Nenhuma imagem adicionada'),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Preço',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Adicionar Imagens',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Url da Imagem',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
