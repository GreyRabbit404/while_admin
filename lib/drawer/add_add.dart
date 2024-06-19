import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:while_admin/models/ad_model.dart';

class AddAdvertisementScreen extends StatefulWidget {
  @override
  _AddAdvertisementScreenState createState() => _AddAdvertisementScreenState();
}

class _AddAdvertisementScreenState extends State<AddAdvertisementScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _organisationController = TextEditingController();
  final TextEditingController _playStoreURLController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();
  final TextEditingController _videoUrlController = TextEditingController();
  final TextEditingController _viewsController = TextEditingController();
  final TextEditingController _likesController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  final CollectionReference _carouselCollection =
      FirebaseFirestore.instance.collection('advertisement');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Advertisement'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              TextFormField(
                controller: _organisationController,
                decoration: const InputDecoration(labelText: 'Organisation'),
              ),
              TextFormField(
                controller: _playStoreURLController,
                decoration: const InputDecoration(labelText: 'Play Store URL'),
              ),
              TextFormField(
                controller: _thumbnailController,
                decoration: const InputDecoration(labelText: 'Thumbnail URL'),
              ),
              TextFormField(
                controller: _videoUrlController,
                decoration: const InputDecoration(labelText: 'Video URL'),
              ),
              TextFormField(
                controller: _viewsController,
                decoration: const InputDecoration(labelText: 'Views'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _likesController,
                decoration: const InputDecoration(labelText: 'Likes (comma separated)'),
              ),
              TextFormField(
                controller: _websiteController,
                decoration: const InputDecoration(labelText: 'Website'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _addAdvertisement();
                },
                child: const Text('Add Advertisement'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addAdvertisement() async {
    try {
      // Parse likes into List<dynamic>
      List<dynamic> likesList = _likesController.text.split(',');

      // Create AdModel object
      AdModel ad = AdModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Generate unique ID
        title: _titleController.text,
        description: _descriptionController.text,
        category: _categoryController.text,
        organisation: _organisationController.text,
        playStoreURL: _playStoreURLController.text,
        thumbnail: _thumbnailController.text,
        videoUrl: _videoUrlController.text,
        views: int.parse(_viewsController.text),
        likes: likesList,
        website: _websiteController.text,
      );

      // Add AdModel to Firestore under 'carousel' > 'a' collection
      await _carouselCollection.doc('carousel').collection('a').add(ad.toJson());

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Advertisement added successfully')),
      );

      // Clear text controllers
      _clearControllers();
    } catch (e) {
      log('Error adding advertisement: $e');
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add advertisement')),
      );
    }
  }

  void _clearControllers() {
    _titleController.clear();
    _descriptionController.clear();
    _categoryController.clear();
    _organisationController.clear();
    _playStoreURLController.clear();
    _thumbnailController.clear();
    _videoUrlController.clear();
    _viewsController.clear();
    _likesController.clear();
    _websiteController.clear();
  }
}
