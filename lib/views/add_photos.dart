import 'package:aquariusstore/components/empty_list_message.dart';
import 'package:aquariusstore/models/product.dart';
import 'package:aquariusstore/services/product_service.dart';
import 'package:aquariusstore/services/upload_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPhotos extends StatefulWidget {
  AddPhotos({this.product});
  final Product product;
  final us = UploadService();
  final ps = ProductService();
  @override
  _AddPhotosState createState() => _AddPhotosState(this.product);
}

class _AddPhotosState extends State<AddPhotos> {
  _AddPhotosState(this.product);
  Product product;

  _addPhoto(bool option) async {
    String url = await widget.us.uploadImage(option);
    setState(() {
      if (product.imagesUrl.length == 0) {
        product.setMainImage(url);
      }
      product.addImage(url);
    });
    widget.ps.updateProduct(product);
  }

  _removePhoto(String url) {
    widget.us.removeImage(url);
    setState(() {
      if (product.mainImageUrl == url) {
        product.mainImageUrl = null;
      }
      product.removeImage(url);
    });
    widget.ps.updateProduct(product);
  }

  _changeMainImage(String url) {
    setState(() {
      product.setMainImage(url);
    });
    widget.ps.updateProduct(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.close(1),
        child: Icon(Icons.list),
      ),
      appBar: AppBar(
        title: Text('${product.name}'),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              product.imagesUrl.length == 0
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
                                          backgroundColor: Colors.black54,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color:
                                                  Theme.of(context).errorColor,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                        SizedBox(
                                            width: u == product.mainImageUrl
                                                ? 0
                                                : 10),
                                        u == product.mainImageUrl
                                            ? Container()
                                            : CircleAvatar(
                                                backgroundColor: Colors.black54,
                                                child: IconButton(
                                                    icon: Icon(
                                                      Icons.done,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    onPressed: () {}),
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
              Text('aaaaa'),
            ],
          ),
        ),
      ),
    );
  }
}
