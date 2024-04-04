import 'dart:convert';

import 'package:http/http.dart' as http;
class APICODE{

  String apiUrl="https://65c33702f7e6ea59682c264f.mockapi.io/Faculty/";
  Future<List<dynamic>> getAllFacultiesFromAPI() async {
    http.Response response=await http.get(Uri.parse(apiUrl));
    List<dynamic> facultyList=jsonDecode(response.body);
    return facultyList;
  }

  Future<void> deleteFacultyFromAPI(String userId) async {
    await http.delete(Uri.parse(apiUrl+userId));
  }

  Future<Map<dynamic, dynamic>> insertFacultyInPost(Map<String, dynamic> map) async {
    http.Response response = await http.post(Uri.parse(apiUrl), body: map);
    Map<dynamic, dynamic> facObject = jsonDecode(response.body);
    return facObject;
  }

  Future<Map<dynamic, dynamic>> updateFacultyInPut(Map<String, dynamic> map) async {
    http.Response response = await http.put(Uri.parse(apiUrl+map['id']), body: map);
    Map<dynamic, dynamic> facObject = jsonDecode(response.body);
    return facObject;
  }
}