import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddVideoCategoryScreen extends StatefulWidget {
  const AddVideoCategoryScreen({super.key});

  @override
  State<AddVideoCategoryScreen> createState() => _AddVideoCategoryScreenState();
}

class _AddVideoCategoryScreenState extends State<AddVideoCategoryScreen> {
  final TextEditingController _videoCategoryNameController = TextEditingController();
  final CollectionReference _collectionRefernce = FirebaseFirestore.instance.collection('videosCategories');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Video Field to Collection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: _videoCategoryNameController,
              decoration: const InputDecoration(
                labelText: 'Video Field Value',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _addFieldToCollection();
                },
                child: const Text('Add Video Field to Collection'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addFieldToCollection() async {
    try {
      String fieldName = _videoCategoryNameController.text;
      DocumentReference documentReference = _collectionRefernce.doc(fieldName);
      documentReference.set({'category': fieldName});
      log("video category added field successfully");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Video Category added  successfully!'),
        ),
      );
    } catch (e) {
      log("error updating user model fields $e");
    }
  }
}
