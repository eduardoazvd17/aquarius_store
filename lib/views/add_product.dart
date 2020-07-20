import 'package:aquariusstore/models/product.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  final Product product;
  AddProduct({this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Enviar',
        child: Icon(
          Icons.done,
        ),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text(product == null ? 'Adicionar Produto' : 'Editar Produto'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Preço',
                ),
              ),
              TextField(
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
