import 'package:aquariusstore/components/empty_list_message.dart';
import 'package:aquariusstore/controllers/product_controller.dart';
import 'package:aquariusstore/models/product.dart';
import 'package:aquariusstore/services/product_service.dart';
import 'package:aquariusstore/services/upload_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProduct extends StatefulWidget {
  AddProduct({this.product});
  final Product product;
  final ProductController productController = Get.find<ProductController>();
  @override
  _AddProductState createState() =>
      _AddProductState(product == null ? Product() : product);
}

class _AddProductState extends State<AddProduct> {
  Product product;
  _AddProductState(this.product);
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();
  bool loadingImage = false;
  final uploadService = UploadService();

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

  _setMainImage(String url) {
    setState(() {
      product.mainImageUrl = url;
    });
  }

  _send() {
    String name = nameController.text;
    String price = priceController.text.replaceAll(',', '.');
    String desc = descriptionController.text;

    if (name.isEmpty ||
        price.isEmpty ||
        desc.isEmpty ||
        product.imagesUrl.length == 0) {
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

    if (product.mainImageUrl == null) {
      setState(() {
        product.mainImageUrl = product.imagesUrl[0];
      });
    }

    var ps = ProductService();

    product.name = name;
    product.price = double.tryParse(price);
    product.description = desc;

    if (widget.product == null) {
      ps.addProduct(product);
    } else {
      ps.updateProduct(product);
    }

    widget.productController.reload();
    Get.close(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _send,
        child: Icon(widget.product == null ? Icons.add : Icons.save),
      ),
      appBar: AppBar(
        title: Text(
            widget.product == null ? 'Adicionar Produto' : 'Editar Produto'),
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (ctx, cnt) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  loadingImage
                      ? Container(
                          height: 250,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : product.imagesUrl.length == 0
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
                              items: product.imagesUrl
                                  .map((u) => Stack(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.center,
                                            child: Image.network(
                                              u,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Colors.black54,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Theme.of(context)
                                                          .errorColor,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: u ==
                                                            product.mainImageUrl
                                                        ? 0
                                                        : 10),
                                                u == product.mainImageUrl
                                                    ? Container()
                                                    : CircleAvatar(
                                                        backgroundColor:
                                                            Colors.black54,
                                                        child: IconButton(
                                                            icon: Icon(
                                                              Icons.done,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                            onPressed: () =>
                                                                _setMainImage(
                                                                    u)),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ))
                                  .toList(),
                              options: CarouselOptions(
                                enableInfiniteScroll: false,
                                enlargeCenterPage: true,
                                height: 250,
                                autoPlay: false,
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
                      'Imagens:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.camera_alt),
                              Text('Camera'),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.image),
                              Text('Galeria'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
