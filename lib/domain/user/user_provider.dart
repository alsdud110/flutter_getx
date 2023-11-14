import 'package:get/get.dart';

const host = "http://172.30.1.92:8080";

// 통신
class UserProvider extends GetConnect {
  Future<Response> login(Map data) => post("$host/login", data);
}