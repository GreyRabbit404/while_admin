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
                .map((doc) =>
                    UserModel.fromMap(doc.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.image),
                    backgroundColor: Colors.grey,
                  ),
                  title: Text(user.name),
                  subtitle: Text(
                      'Followers: ${user.follower} Following: ${user.following}'),
                  trailing: Icon(
                    user.isOnline == 1 ? Icons.circle : Icons.circle_outlined,
                    color: user.isOnline == 1 ? Colors.green : Colors.red,
                  ),
                  onTap: () {
                    // Handle tap if needed
                  },
                );
              },
            );
          },
        ));
  }
}
