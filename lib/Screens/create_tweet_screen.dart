// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/Constants/Constants.dart';
import 'package:twitter/Models/Tweet.dart';
import 'package:twitter/Services/database_services.dart';
import 'package:twitter/Services/storage_service.dart';
import 'package:twitter/Widgets/rounded_button.dart';

class CreateTweetScreen extends StatefulWidget {
  final String currentUserId;

  const CreateTweetScreen({Key? key, required this.currentUserId})
      : super(key: key);
  @override
  CreateTweetScreenState createState() => CreateTweetScreenState();
}

class CreateTweetScreenState extends State<CreateTweetScreen> {
  String _tweetText = '';
  File? _pickedImage;
  bool _loading = false;

  handleImageFromGallery() async {
    try {
      // File imageFile = (await ImagePicker(source: ImageSource.gallery)) as File;
      final ImagePicker picker = ImagePicker();
      final XFile? imageFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        setState(() {
          _pickedImage = imageFile.path as File?;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kTweeterColor,
        centerTitle: true,
        title: const Text(
          'Tweet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              maxLength: 280,
              maxLines: 7,
              decoration: const InputDecoration(
                hintText: 'Enter your Tweet',
              ),
              onChanged: (value) {
                _tweetText = value;
              },
            ),
            const SizedBox(height: 10),
            _pickedImage == null
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            color: kTweeterColor,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(_pickedImage!),
                            )),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
            GestureDetector(
              onTap: handleImageFromGallery,
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                    color: kTweeterColor,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 50,
                  color: kTweeterColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            RoundedButton(
              btnText: 'Tweet',
              onBtnPressed: () async {
                setState(() {
                  _loading = true;
                });
                if (_tweetText.isNotEmpty) {
                  String image;
                  if (_pickedImage == null) {
                    image = '';
                  } else {
                    image =
                        await StorageService.uploadTweetPicture(_pickedImage!);
                  }
                  Tweet tweet = Tweet(
                    id: '',
                    text: _tweetText,
                    image: image,
                    authorId: widget.currentUserId,
                    likes: 0,
                    retweets: 0,
                    timestamp: Timestamp.fromDate(
                      DateTime.now(),
                    ),
                  );
                  DatabaseServices.createTweet(tweet);
                  Navigator.pop(context);
                }
                setState(() {
                  _loading = false;
                });
              },
            ),
            const SizedBox(height: 20),
            _loading
                ? const CircularProgressIndicator()
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
