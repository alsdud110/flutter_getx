import 'package:get/get.dart';

const host = "http://172.30.1.91:8080";

// 통신
class UserProvider extends GetConnect {
  Future<Response> login(Map data) => post("$host/login", data);

  Future<Response> join(Map data) => post("$host/join", data);
}
