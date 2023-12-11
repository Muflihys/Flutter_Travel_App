import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/modules/home/controllers/ClientController.dart';

class DatabaseController extends ClientController {
  Storage? storage;

  @override
  void onInit() {
    super.onInit();

    storage = Storage(client);
  }

  Future storeImage() async{
    try{
      final result = await storage !.createFile(bucketId: '[BUCKET_ID]', fileId: ID.unique(), file: InputFile.fromPath(path: './col_travel_app/image.jpg', filename: 'image.jpg'),);
      print("Storage Controller :: storeImage $result");
    }catch(error){
      Get.defaultDialog(
        title: "Error Storage",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }
}
