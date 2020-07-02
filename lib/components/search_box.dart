import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: 'O que está procurando?',
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
