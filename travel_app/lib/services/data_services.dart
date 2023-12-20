import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_app/model/data_model.dart';

class DataServices {
  Future<List<DataModel>> getInfo() async {
    final baseUrl = "https://travelappapi-d6ef4-default-rtdb.firebaseio.com/datagunung.json";
    final response = await http.get(Uri.parse(baseUrl));

    print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data != null) {
          final List<DataModel> result = [];
          data.forEach((key, value) {
            result.add(DataModel.fromJson(value));
          });
          return result;
        }
      } catch (e) {
        print("Error parsing response: $e");
      }
    }
    return <DataModel>[];
  }
}