import 'dart:convert';

import 'package:flutter_testing/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Future<List<UserData>> fetchUserData() async {
    var response =
        await http.get(Uri.parse('https://randomuser.me/api/?results=100'));
    return List.generate(jsonDecode(response.body)['results'].length, (i) {
      return UserData(
        firstname: jsonDecode(response.body)['results'][i]['name']['first'],
        lastname: jsonDecode(response.body)['results'][i]['name']['last'],
        email: jsonDecode(response.body)['results'][i]['email'],
        tel: jsonDecode(response.body)['results'][i]['phone'],
        image: jsonDecode(response.body)['results'][i]['picture']['large'],
      );
    });
  }
}
