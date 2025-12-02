import 'package:advicer/domain/usecases/entities/advice_entities.dart';
import 'package:advicer/infrastructure/repositories/models/advicer_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AdvicerRemoteDatasources {
  /// requests a random advice from free api.
  /// throws a server-Exception, if respond code is'nt 200.
  Future<AdviceEntities> getRandomAdviceFromApi();
}

class AdvicerRemoteDatasourcesImpl implements AdvicerRemoteDatasources {
  final http.Client client = http.Client();

  @override
  Future<AdviceEntities> getRandomAdviceFromApi() async {
    final response = await client.get(
      Uri.parse("https://api.adviceslip.com/advice"),

      headers: {'Content-Type': 'application/jason'},
    );

    final responsBody = json.decode(response.body);

    return AdvicerModels.fromJson(responsBody["slip"]);
  }
}
