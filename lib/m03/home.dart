import 'package:flutter/material.dart';
import 'package:latihan_mobile_backend/m03/dbhelper.dart';
import 'package:latihan_mobile_backend/m03/item_screen.dart';
import 'package:latihan_mobile_backend/m03/my_provider.dart';
import 'package:latihan_mobile_backend/m03/shopping_list.dart';
import 'package:latihan_mobile_backend/m03/shopping_list_dialog.dart';
import 'package:provider/provider.dart';

class Home3 extends StatefulWidget {
  const Home3({super.key});

  @override
  State<Home3> createState() => _Home3State();
}

class _Home3State extends State<Home3> {
  DBHelper _dbHelper = DBHelper();
  int id = 0;

  @override
  void dispose() {
    _dbHelper.closeDB();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ListProductProvider>(context);
    _dbHelper.getShoppingList().then((shoppingList) {
      prov.setShoppingList = shoppingList;
      if (shoppingList.isNotEmpty) {
        id = shoppingList.last.id;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.history),
            tooltip: 'History',
          ),
          IconButton(
            onPressed: () {
              _dbHelper.deleteAllShoppingList();
              prov.deleteAll();
            },
            icon: const Icon(Icons.delete),
            tooltip: 'Delete All',
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await showDialog(
                context: context,
                builder: (context) {
                  return ShoppingListDialog(_dbHelper)
                      .buildDialog(context, ShoppingList(++id, '', 0), true);
                });

            _dbHelper.getShoppingList().then((value) => prov.setShoppingList = value);
          }),
      body: ListView.builder(
          itemCount: prov.getShoppingList.isNotEmpty ? prov.getShoppingList.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(prov.getShoppingList[index].id.toString()),
                onDismissed: (direction) {
                  String tempName = prov.getShoppingList[index].name;
                  int tempId = prov.getShoppingList[index].id;

                  _dbHelper.deleteShoppingList(tempId);
                  prov.deleteById(tempId);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('$tempName deleted'),
                  ));
                },
                child: ListTile(
                  title: Text(prov.getShoppingList[index].name),
                  leading: CircleAvatar(
                    child: Text(prov.getShoppingList[index].sum.toString()),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ItemScreen(shoppingList: prov.getShoppingList[index])));
                  },
                  trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ShoppingListDialog(_dbHelper)
                                  .buildDialog(context, prov.getShoppingList[index], false);
                            });
                      }),
                ));
          }),
    );
  }
}
