import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/model/data_model.dart';
import 'package:travel_app/services/data_services.dart'; // Adjust the import based on your project structure

void main() {
  group('DataServices API Test', () {
    test('Fetch data from API', () async {
      final dataServices = DataServices();
      final response = await dataServices.getInfo();

      expect(response, isA<List<DataModel>>());
      expect(response, isNotEmpty);

      for (var item in response) {
        expect(item.name, isNotNull);
        expect(item.img, isNotNull);
        expect(item.price, isNotNull);
        expect(item.people, isNotNull);
        expect(item.stars, isNotNull);
        expect(item.description, isNotNull);
        expect(item.location, isNotNull);
      }
    });
  });
}
