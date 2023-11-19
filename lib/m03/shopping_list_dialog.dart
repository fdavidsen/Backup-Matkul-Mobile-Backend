import 'package:flutter/material.dart';
import 'package:flutter_application_1/m03/dbhelper.dart';
import 'package:flutter_application_1/m03/shopping_list.dart';

class ShoppingListDialog {
  DBHelper _dbHelper;

  ShoppingListDialog(this._dbHelper);

  final nameController = TextEditingController();
  final sumController = TextEditingController();

  Widget buildDialog(BuildContext context, ShoppingList list, bool isNew) {
    if (!isNew) {
      nameController.text = list.name;
      sumController.text = list.sum.toString();
    } else {
      nameController.text = '';
      sumController.text = '';
    }

    return AlertDialog(
      title: Text(isNew ? 'New Shopping List' : 'Edit SHopping List'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Shopping List Name'),
            ),
            TextField(
              controller: sumController,
              decoration: const InputDecoration(hintText: 'Sum'),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    list.name = nameController.text.isNotEmpty ? nameController.text : 'Empty';
                    list.sum = sumController.text.isNotEmpty ? int.parse(sumController.text) : 0;

                    _dbHelper.insertShoppingList(list);

                    Navigator.pop(context);
                  },
                  child: const Text('Save Shopping List')),
            )
          ],
        ),
      ),
    );
  }
}
