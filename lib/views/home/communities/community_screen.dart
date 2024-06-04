import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:while_admin/models/community_model.dart';

class CommunitiesListScreen extends StatelessWidget {
  const CommunitiesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Communities"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('communities').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final communities = snapshot.data!.docs
                .map((doc) =>
                    CommunityModel.fromMap(doc.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
              itemCount: communities.length,
              itemBuilder: (context, index) {
                final community = communities[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(community.image),
                    backgroundColor: Colors.grey,
                  ),
                  title: Text(community.name),
                  subtitle: Text(
                      'Admin: ${community.admin} Domain: ${community.domain}'),
                  trailing: Column(
                    children: [
                      const Text(
                        "no of users",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(community.noOfUsers,
                          style: const TextStyle(fontSize: 14))
                    ],
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
