import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_testing/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserApi {
  String userApi = dotenv.get("USER_API", fallback: "");
  Future<List<UserData>> fetchUserData() async {
    final response = await http.get(Uri.parse('$userApi/api/?results=100'));
    final jsonData = jsonDecode(response.body)['results'] as List;
    return jsonData
        .map((item) => UserData(
              firstname: item['name']['first'],
              lastname: item['name']['last'],
              email: item['email'],
              tel: item['phone'],
              image: item['picture']['large'],
            ))
        .toList();
  }
}
