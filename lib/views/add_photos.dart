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
  _AddPhotosState createState() => _AddPhotosState(
        this.product,
        product.imagesUrl.length == 0
            ? 0
            : product.imagesUrl.indexOf(product.mainImageUrl),
      );
}

class _AddPhotosState extends State<AddPhotos> {
  _AddPhotosState(this.product, this._carouselIndex);
  int _carouselIndex;
  Product product;
  bool loadingImage = false;

  _addPhoto(bool option) async {
    setState(() {
      loadingImage = true;
    });
    String url = await widget.us.uploadImage(option);
    if (url != null) {
      setState(() {
        if (product.imagesUrl.length == 0) {
          product.setMainImage(url);
        }
        product.addImage(url);
        loadingImage = false;
      });
      widget.ps.updateProduct(product);
    }
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
              loadingImage
                  ? Container(
                      height: 300,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : product.imagesUrl.length == 0
                      ? Container(
                          height: 300,
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
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                ),
                                                onPressed: () =>
                                                    _removePhoto(u),
                                              ),
                                            ),
                                            SizedBox(
                                                width: u == product.mainImageUrl
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
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      onPressed: () =>
                                                          _changeMainImage(u),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ))
                              .toList(),
                          options: CarouselOptions(
                            initialPage:
                                product.imagesUrl.indexOf(product.mainImageUrl),
                            onPageChanged: (index, _) {
                              setState(() {
                                _carouselIndex = index;
                              });
                            },
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                            height: 300,
                            autoPlay: false,
                          ),
                        ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: product.imagesUrl.map((item) {
                  int index = product.imagesUrl.indexOf(item);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _carouselIndex == index
                          ? Theme.of(context).primaryColor
                          : Color.fromRGBO(0, 0, 0, 0.3),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ListTile(
                enabled: product.imagesUrl.length < 5,
                onTap: () => _addPhoto(true),
                leading: Icon(
                  Icons.camera_alt,
                ),
                title: Text('Tirar foto'),
              ),
              ListTile(
                enabled: product.imagesUrl.length < 5,
                onTap: () => _addPhoto(false),
                leading: Icon(
                  Icons.photo_size_select_actual,
                ),
                title: Text('Selecionar da galeria'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
