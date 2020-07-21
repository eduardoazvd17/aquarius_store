import 'package:aquariusstore/controllers/product_controller.dart';
import 'package:aquariusstore/models/product.dart';
import 'package:aquariusstore/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProduct extends StatefulWidget {
  final Product product;
  AddProduct({this.product});

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var p = widget.product;
    if (p != null) {
      nameController.text = p.name;
      priceController.text = p.price.toStringAsFixed(2);
      descriptionController.text = p.description;
    }
  }

  _send() {
    var ps = ProductService();
    String name = nameController.text;
    double price = double.tryParse(priceController.text.replaceAll(',', '.'));
    String description = descriptionController.text;

    if (name.isEmpty || price == null || description.isEmpty) {
      Get.snackbar(
        'Campos vazios',
        'Preencha todos os campos necessários.',
        backgroundColor: Theme.of(context).errorColor,
      );
      return;
    }

    if (widget.product == null) {
      var product = Product(
        name: name,
        price: price,
        description: description,
      );
      ps.addProduct(product);
    } else {
      var product = widget.product;
      product.name = name;
      product.price = price;
      product.description = description;
      ps.updateProduct(product);
    }
    Get.close(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Enviar',
        child: Icon(
          widget.product == null ? Icons.done : Icons.save,
        ),
        onPressed: _send,
      ),
      appBar: AppBar(
        title: Text(
            widget.product == null ? 'Adicionar Produto' : 'Editar Produto'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Preço',
                ),
              ),
              TextField(
                controller: descriptionController,
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
