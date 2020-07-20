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
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();
  bool loadingImage = false;
  final uploadService = UploadService();
  List<String> urls = [];
  String mainUrl;

  @override
  void initState() {
    super.initState();
    var p = widget.product;
    if (p != null) {
      nameController.text = p.name;
      priceController.text = p.price.toStringAsFixed(2);
      descriptionController.text = p.description;
      setState(() {
        urls = p.imagesUrl;
        mainUrl = p.mainImageUrl;
      });
    }
  }

  _setMainImage(String url) {
    setState(() {
      mainUrl = url;
    });
  }

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

    if (mainUrl == null) {
      setState(() {
        mainUrl = urls[0];
      });
    }

    var ps = ProductService();
    if (widget.product == null) {
      var product = Product(
        name: name,
        price: double.tryParse(price),
        description: desc,
        imagesUrl: urls,
        mainImageUrl: mainUrl,
      );
      ps.addProduct(product);
    } else {
      var product = Product(
        id: widget.product.id,
        name: name,
        price: double.tryParse(price),
        description: desc,
        imagesUrl: urls,
        mainImageUrl: mainUrl,
      );
      ps.updateProduct(product);
    }
    widget.productController.reload();
    Get.close(1);
  }

  _addPhoto(bool opc) async {
    setState(() {
      loadingImage = true;
    });
    String url = await uploadService.uploadImage(opc, widget.product);
    setState(() {
      if (url != null) urls.add(url);
      loadingImage = false;
    });
  }

  _removePhoto(String url) {
    Get.dialog(AlertDialog(
      title: Text('Remover imagem'),
      content: Text('Deseja realmente remover esta imagem?'),
      actions: <Widget>[
        FlatButton(
          textColor: Theme.of(context).accentColor,
          onPressed: () {
            setState(() {
              if (url == mainUrl) {
                mainUrl = null;
              }
              uploadService.removeImage(widget.product.id, urls.indexOf(url));
              urls.remove(url);
            });
            Get.close(1);
          },
          child: Text('Sim'),
        ),
        FlatButton(
          textColor: Theme.of(context).accentColor,
          onPressed: () => Get.close(1),
          child: Text('Não'),
        ),
      ],
    ));
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
                      : urls.length == 0
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
                                                    onPressed: () =>
                                                        _removePhoto(u),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width:
                                                        u == mainUrl ? 0 : 10),
                                                u == mainUrl
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
                          onTap: () => _addPhoto(true),
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
                          onTap: () => _addPhoto(false),
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
