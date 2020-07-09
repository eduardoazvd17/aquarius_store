import 'package:aquariusstore/components/empty_list_message.dart';
import 'package:aquariusstore/controllers/product_controller.dart';
import 'package:aquariusstore/models/product.dart';
import 'package:aquariusstore/services/product_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProduct extends StatefulWidget {
  final ProductController productController = Get.find<ProductController>();
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var urlController = TextEditingController();
  var descriptionController = TextEditingController();
  List<String> urls = [];

  _send() {
    String name = nameController.text;
    String price = priceController.text.replaceAll(',', '.');
    String desc = descriptionController.text;

    if (name.isEmpty || price.isEmpty || desc.isEmpty || urls.length == 0) {
      Get.snackbar(
        'Campos não preenchidos',
        'Todos os campos devem ser preenchidos e deve ser enviado pelo menos uma imagem.',
        backgroundColor: Theme.of(context).errorColor,
      );
      return;
    }

    if (double.tryParse(price) == null) {
      Get.snackbar(
        'Preço inválido',
        'Insira um valor válido.',
        backgroundColor: Theme.of(context).errorColor,
      );
      return;
    }

    var product = Product(
      name: name,
      price: double.tryParse(price),
      description: desc,
      imagesUrl: urls,
    );

    var ps = ProductService();
    ps.addProduct(product);
    widget.productController.add(product);
  }

  _addPhoto() {
    var url = urlController.text;
    urlController.clear();
    if (urls.contains(url)) {
      Get.snackbar(
        'Imagem já adicionada',
        'Esta url de imagem já foi inserida neste produto.',
        backgroundColor: Theme.of(context).errorColor,
      );
      return;
    }
    if (!GetUtils.isURL(url)) {
      Get.snackbar(
        'Url inválida',
        'Insira uma url de imagem válida.',
        backgroundColor: Theme.of(context).errorColor,
      );
    } else {
      setState(() {
        urls.add(url);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _send,
        child: Icon(Icons.add),
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
                  urls.length == 0
                      ? Container(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.camera_alt, size: 50),
                              SizedBox(height: 10),
                              EmptyListMessage('Nenhuma imagem adicionada'),
                            ],
                          ),
                        )
                      : CarouselSlider(
                          items: urls
                              .map((u) => Image.network(u, fit: BoxFit.cover))
                              .toList(),
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            height: 250,
                            autoPlay: true,
                            pauseAutoPlayOnManualNavigate: true,
                          ),
                        ),
                  SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      suffixIcon: Icon(Icons.content_paste),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: priceController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Preço',
                      suffixIcon: Icon(Icons.attach_money),
                    ),
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Imagens',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: urlController,
                          decoration: InputDecoration(
                            labelText: 'Url da imagem',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_photo_alternate),
                        onPressed: _addPhoto,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                        labelText: 'Descrição',
                        suffixIcon: Icon(Icons.description)),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
