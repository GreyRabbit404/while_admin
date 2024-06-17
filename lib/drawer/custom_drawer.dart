import 'package:flutter/material.dart';
import 'package:while_admin/drawer/update_model.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            child: Center(
              child: Text(
                'Custom Functions Drawer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add),
            tileColor: Colors.amber, // Set the tileColor directly here
            title: const Text(
              'Add field to user model',
              style: TextStyle(color: Colors.black), // Text color
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddFieldValueToAllUsers(),
                  ));
              // Update the state of the app.
              // ...
            },
          ),
          const Divider(
            height: 10,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.remove),
            tileColor: Colors.amber, // Set the tileColor directly here
            title: const Text(
              'Remove field from user model',
              style: TextStyle(color: Colors.black), // Text color
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddFieldValueToAllUsers(),
                  ));
              // Update the state of the app.
              // ...
            },
          ),
          const Divider(
            height: 10,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
