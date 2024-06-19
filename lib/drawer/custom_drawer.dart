import 'package:flutter/material.dart';
import 'package:while_admin/drawer/add_add.dart';
import 'package:while_admin/drawer/update_loop.dart';
import 'package:while_admin/drawer/update_model.dart';
import 'package:while_admin/drawer/update_video_model.dart';

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
                    builder: (context) => const AddFieldValueToAllUsers(),
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
            leading: const Icon(Icons.add),
            tileColor: Colors.amber, // Set the tileColor directly here
            title: const Text(
              'Add Field Value to Video Model',
              style: TextStyle(color: Colors.black), // Text color
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddFieldValueToVideoModel(),
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
            leading: const Icon(Icons.add),
            tileColor: Colors.amber, // Set the tileColor directly here
            title: const Text(
              'Add Field Value to Loops Model',
              style: TextStyle(color: Colors.black), // Text color
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddFieldToAllLoops(),
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
            leading: const Icon(Icons.campaign_outlined),
            tileColor: Colors.amber, // Set the tileColor directly here
            title: const Text(
              'Add Advertisement',
              style: TextStyle(color: Colors.black), // Text color
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddAdvertisementScreen(),
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
