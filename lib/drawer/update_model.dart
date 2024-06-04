import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFieldValueToAllUsers extends StatefulWidget {
  AddFieldValueToAllUsers({super.key});

  @override
  State<AddFieldValueToAllUsers> createState() => _AddFieldValueToAllUsersState();
}

class _AddFieldValueToAllUsersState extends State<AddFieldValueToAllUsers> {
  final TextEditingController _fieldContoller = TextEditingController();

  final TextEditingController _valueController = TextEditingController();

  final CollectionReference _collectionRefernce = FirebaseFirestore.instance.collection('users');

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Field to Collection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _fieldContoller,
              decoration: const InputDecoration(labelText: 'Field Name'),
            ),
            TextField(
              controller: _valueController,
              decoration: const InputDecoration(labelText: 'Field Value'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _addFieldToCollection();
                },
                child: const Text('Add Field to Collection'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addFieldToCollection() async {
    try {
      String fieldName = _fieldContoller.text;
      dynamic fieldValue = _valueController.value;

      final QuerySnapshot querySnapshot = await _collectionRefernce.get();
      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        DocumentReference documentReference = _collectionRefernce.doc(docSnapshot.id);
        documentReference.update({fieldName: fieldValue});
      }
      log("added field successfully to all users");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Field added to all documents successfully!'),
        ),
      );
    } catch (e) {
      log("error updating user model fields $e");
    }
  }
}
