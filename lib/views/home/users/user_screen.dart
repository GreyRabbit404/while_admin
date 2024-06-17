import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:while_admin/models/user_model.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs
              .map((doc) {
                try {
                  return UserModel.fromJson(doc.data() as Map<String, dynamic>);
                } catch (e) {
                  print('Error parsing document ${doc.id}: $e');
                  return null; // Return null for invalid documents
                }
              })
              .where((user) => user != null)
              .toList();

          // Create a list of document IDs that failed to parse
          List<String> failedIds = [];
          for (var doc in snapshot.data!.docs) {
            if (!users.any((user) => user!.id == doc.id)) {
              failedIds.add(doc.id);
            }
          }

          return failedIds.isEmpty
              ? ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user!.image),
                        backgroundColor: Colors.grey,
                      ),
                      title: Text(user.name),
                      subtitle: Text('Followers: ${user.follower} Following: ${user.following}'),
                      trailing: Icon(
                        user.isOnline == 1 ? Icons.circle : Icons.circle_outlined,
                        color: user.isOnline == 1 ? Colors.green : Colors.red,
                      ),
                      onTap: () {
                        // Handle tap if needed
                      },
                    );
                  },
                )
              : ListView.builder(
                  itemCount: failedIds.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(failedIds[index]),
                      // You can customize the ListTile as needed
                    );
                  },
                );
        },
      ),
    );
  }
}
