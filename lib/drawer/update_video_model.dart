import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFieldValueToVideoModel extends StatefulWidget {
  const AddFieldValueToVideoModel({super.key});

  @override
  State<AddFieldValueToVideoModel> createState() => _AddFieldValueToVideoModelState();
}

class _AddFieldValueToVideoModelState extends State<AddFieldValueToVideoModel> {
  final TextEditingController _fieldContoller = TextEditingController();

  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  final CollectionReference _collectionRefernce = FirebaseFirestore.instance.collection('videos');
  List<String> dropdownValues = ['String', 'int', 'double', 'bool', 'null', 'DateTime'];

  String dropdownValue = 'String';

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
            TextField(
              controller: _fieldContoller,
              decoration: const InputDecoration(labelText: 'Field Name'),
            ),
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  _typeController.text = newValue;
                });
              },
              items: dropdownValues.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _typeController,
              decoration: const InputDecoration(
                labelText: 'Selected Value',
                border: OutlineInputBorder(),
              ),
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
      String fieldName = _fieldContoller.text;
      dynamic fieldValue = _valueController.text;
      String type = _typeController.text;

      final QuerySnapshot querySnapshot = await _collectionRefernce.get();
      log(querySnapshot.docs.isEmpty.toString());
      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        log(docSnapshot.id);
        DocumentReference documentReference = _collectionRefernce.doc(docSnapshot.id);
        QuerySnapshot subcollectionSnapshot = await documentReference.collection(docSnapshot.id).get();
        log(subcollectionSnapshot.docs.first.id);
        final subCollection = docSnapshot.id;
        for (DocumentSnapshot doc in subcollectionSnapshot.docs) {
          DocumentReference docRef = documentReference.collection(subCollection).doc(doc.id);
          if (type == 'String') {
            docRef.update({fieldName: fieldValue.toString()});
          } else if (type == 'int') {
            docRef.update({fieldName: int.parse(fieldValue)});
          } else if (type == 'double') {
            docRef.update({fieldName: double.parse(fieldValue)});
          } else if (type == 'bool') {
            docRef.update({fieldName: bool.parse(fieldValue)});
          } else if (type == 'DateTime') {
            docRef.update({fieldName: DateTime.parse(fieldValue)});
          } else {
            docRef.update({fieldName: null});
          }
        }
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
