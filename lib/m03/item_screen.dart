import 'package:flutter/material.dart';
import 'package:flutter_application_1/m03/shopping_list.dart';

class ItemScreen extends StatefulWidget {
  final ShoppingList shoppingList;

  const ItemScreen({super.key, required this.shoppingList});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.shoppingList.name)),
    );
  }
}
