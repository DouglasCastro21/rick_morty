import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_morty/core/error/exception.dart';
import 'package:rick_morty/feature_persons/data/models/person_model.dart';


abstract class PersonRemoteDataSource {

  Future<List<PersonModel>> getAllPersons(int page);


  Future<List<PersonModel>> searchPersons(String query);
}


class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client});


  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonsFromUrl(
      'https://rickandmortyapi.com/api/character/?page=$page');

  @override
  Future<List<PersonModel>> searchPersons(String query) => _getPersonsFromUrl(
      'https://rickandmortyapi.com/api/character/?page=2&name=$query');

  Future<List<PersonModel>> _getPersonsFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final persons = jsonDecode(response.body);
      return (persons['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
