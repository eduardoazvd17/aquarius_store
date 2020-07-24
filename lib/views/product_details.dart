import 'package:aquariusstore/components/no_image.dart';
import 'package:aquariusstore/controllers/user_controller.dart';
import 'package:aquariusstore/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  final Product product;
  ProductDetails(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Produto'),
        centerTitle: false,
      ),
      bottomSheet: Container(
        height: 80,
        color: Colors.black12,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    'R\$' + product.price.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.shopping_cart),
                      SizedBox(width: 5),
                      Text('Adicionar ao Carrinho'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              child: Hero(
                transitionOnUserGestures: true,
                tag: product.id,
                child: product.imagesUrl.length == 0
                    ? FittedBox(fit: BoxFit.cover, child: NoImage())
                    : CarouselSlider(
                        items: product.imagesUrl
                            .map(
                              (u) => Image.network(
                                u,
                                fit: BoxFit.cover,
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          initialPage:
                              product.imagesUrl.indexOf(product.mainImageUrl),
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                          height: 300,
                          autoPlay: true,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
