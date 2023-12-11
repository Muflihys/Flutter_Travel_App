// File: appwrite_client.dart
import 'package:appwrite/appwrite.dart';

class AppwriteClientService {
  Client client = Client();

  AppwriteClientService() {
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('656852c8dfdb205befa1')
        .setSelfSigned(status: true); // Hanya untuk pengembangan
  }
}
