import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Requests'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.face), text: 'Creators'),
              Tab(icon: Icon(Icons.school), text: 'Counsellors'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CreatorRequestsWidget(), // Refactored existing widget for creators
            CounsellorRequestsWidget(), // New widget for counsellors
          ],
        ),
      ),
    );
  }
}

// Widget for handling creator requests
class CreatorRequestsWidget extends StatelessWidget {
  const CreatorRequestsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('requests')
          .where('isContentCreator', isEqualTo: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: snapshot.data?.docs.length ?? 0,
          itemBuilder: (context, index) {
            DocumentSnapshot request = snapshot.data!.docs[index];
            String instagramId = request['instagramLink'] ?? 'Not provided';
            String youtubeId = request['youtubeLink'] ?? 'Not provided';

            return Column(
              children: [
                ListTile(
                  title: Text(request['userId'] ?? 'No User ID'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Instagram ID: $instagramId'),
                      Text('YouTube ID: $youtubeId'),
                      Text(
                          'Timestamp: ${request['timeStamp'].toDate().toString()}'),
                    ],
                  ),
                  trailing: approveButton(context, request),
                ),
                const Divider(),
              ],
            );
          },
        );
      },
    );
  }

  Widget approveButton(BuildContext context, DocumentSnapshot request) {
    return IconButton(
      icon: const Icon(Icons.check_circle, color: Colors.green),
      onPressed: () => updateStatus(context, request),
    );
  }

  Future<void> updateStatus(
      BuildContext context, DocumentSnapshot request) async {
    final String userId = request['userId'];
    final firestoreInstance = FirebaseFirestore.instance;

    try {
      await firestoreInstance
          .collection('users')
          .doc(userId)
          .update({'isContentCreator': true});
      await firestoreInstance
          .collection('requests')
          .doc(request.id)
          .update({'isContentCreator': true});
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Request approved for user ID: $userId")));
    } catch (error) {
      print("Failed to update: $error");
    }
  }
}

// New widget for handling counsellor requests
class CounsellorRequestsWidget extends StatelessWidget {
  const CounsellorRequestsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('CounsellerRequests')
          .where('isCounsellor', isEqualTo: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: snapshot.data?.docs.length ?? 0,
          itemBuilder: (context, index) {
            DocumentSnapshot request = snapshot.data!.docs[index];
            return ExpansionTile(
              trailing: counsellorapproveButton(request, context),
              title: Text(request['userId'] ?? 'No User ID'),
              subtitle: Text(
                  'Timestamp: ${request['timeStamp'].toDate().toString()}'),
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('CounsellerRequests')
                      .doc(request.id)
                      .collection('Categories')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> subSnapshot) {
                    if (subSnapshot.hasError) {
                      return const Text(
                          'Something went wrong with subcollection');
                    }
                    if (subSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      );
                    }
                    return Column(
                      children: subSnapshot.data!.docs.map((doc) {
                        Map<String, dynamic> categoryData =
                            doc.data() as Map<String, dynamic>;
                        return ListTile(
                          title: Text(doc.id),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Years of Experience: ${categoryData['yearsOfExperience'].toString()}'),
                              Text(
                                  'Organisation: ${categoryData['organisation']}'),
                              Text(
                                  'Customers Catered: ${categoryData['customersCatered'].toString()}'),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

Widget counsellorapproveButton(DocumentSnapshot request, BuildContext context) {
  return IconButton(
      icon: const Icon(Icons.check_circle, color: Colors.green),
      onPressed: () {
        log("tapped");
        fetchAndStoreCounsellors();
        updateCounsellorStatus(context, request);
      });
}

Future<void> updateCounsellorStatus(
    BuildContext context, DocumentSnapshot request) async {
  final String userId = request['userId'];
  final firestoreInstance = FirebaseFirestore.instance;

  try {
    await firestoreInstance
        .collection('users')
        .doc(userId)
        .update({'isCounsellor': true});
    await firestoreInstance
        .collection('CounsellerRequests')
        .doc(request.id)
        .update({'isCounsellor': true});
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Request approved for user ID: $userId")));
  } catch (error) {
    print("Failed to update: $error");
  }
}

void fetchAndStoreCounsellors() async {
  // Step 1: Query documents where the field "counseller" is false
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
      .instance
      .collection('CounsellerRequests')
      .where('isCounsellor', isEqualTo: false)
      .get();
  log("${querySnapshot.docs.length}documents");
  // Step 2: Iterate through each document
  querySnapshot.docs.forEach((doc) async {
    String requestId = doc.id;
    log(doc.data().toString());
    QuerySnapshot<Map<String, dynamic>> insideSnapshot = await FirebaseFirestore
        .instance
        .collection('CounsellerRequests')
        .doc(requestId)
        .collection('Categories')
        .get();
    for (var doc in insideSnapshot.docs) {
      // Print each document's data
      var data = doc.data();
      data['counsellerId'] = requestId;
      debugPrint('Document ID: ${doc.id}');
      debugPrint('Document data: ${doc.data()}');
      await FirebaseFirestore.instance
          .collection('counsellers')
          .doc(doc.id)
          .collection('counsellersData')
          .add(data);
    }
  });
}
