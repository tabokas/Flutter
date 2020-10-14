import 'dart:io';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:forteapp/user_profile_init.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


File _pickedImage;
Firestore _firestore = Firestore.instance;
String _retrievedImageUrl;

  Future<CloudStorageResult> uploadImage({
    @required File pictureImage,
    //@required File passportImage,
    @required String fileName,
    //@required String fileName2,
  }) async {
    //var imageFileName = title + DateTime.now().millisecondsSinceEpoch.toString();


    //Get the reference to the file we want to create
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child(fileName)
    ;

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_pickedImage);

    StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageSnapshot.ref.getDownloadURL();

    if (uploadTask.isComplete) {
      var url = downloadUrl.toString();
      return CloudStorageResult(
        imageUrl: url,
      //  imageFileName: imageFileName,
      );
    }


    String imageUrl = await firebaseStorageRef.getDownloadURL();
    await _firestore.collection("users").document("loggedinuserid").setData({
      "profilePicture": imageUrl,
    });


  }



class CloudStorageResult {
  final String imageUrl;
 // final String imageFileName;

  CloudStorageResult({this.imageUrl,
    //this.imageFileName
  });
}

Future uploadMultipleImages() async {
  List<File> _pickedImageList = List();
  List<String> _pickedImageUrls = List();

  _pickedImageList.add(_pickedImage);
  _pickedImageList.add(_pickedImage);
  _pickedImageList.add(_pickedImage);

  try {
    for (int i = 0; i < _pickedImageList.length; i++) {
      final StorageReference storageReference = FirebaseStorage().ref().child("multiple2/$i");

      final StorageUploadTask uploadTask = storageReference.putFile(_pickedImageList[i]);



      String imageUrl = await storageReference.getDownloadURL();
      _pickedImageUrls.add(imageUrl); //all all the urls to the list
    }
    //upload the list of imageUrls to firebase as an array
    await _firestore.collection("users").document("loggedinuserid").setData({
      "arrayOfImages": _pickedImageUrls,
    });
  } catch (e) {
    print(e);
  }
}


