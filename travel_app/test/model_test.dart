import 'package:flutter_test/flutter_test.dart';

import 'package:travel_app/model/data_model.dart';

void main() {

  group('Model class tests', () {

    test('DataModel.fromJson() should create a DataModel object from JSON', () {

      // Arrange

      final Map<String, dynamic> jsonData = {

        "name": "Semeru Mountain",

        "img": "coba",

        "price": 5000,

        "people": 10,

        "stars": 2,

        "description": "abogoboga",

        "location": "expected",

      };


      // Act

      final DataModel model = DataModel.fromJson(jsonData);


      // Assert

      expect(model.name, equals("Semeru Mountain"));

      expect(model.img, equals("coba"));

      expect(model.price, equals(5000));

      expect(model.people, equals(10));

      expect(model.stars, equals(2));

      expect(model.description, equals("abogoboga"));

      expect(model.location, equals("expected"));

    });

  });

}