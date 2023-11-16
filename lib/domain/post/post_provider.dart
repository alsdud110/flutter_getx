import 'package:flutter_blog/view/pages/util/jwt.dart';
import 'package:get/get.dart';

const host = "http://172.30.1.91:8080";

// 통신
class PostProvider extends GetConnect {
  Future<Response> findAll() =>
      get("$host/post", headers: {"Authorization": jwtToken ?? ""});

  Future<Response> findById(int id) =>
      get("$host/post/$id", headers: {"Authorization": jwtToken ?? ""});

  Future<Response> deleteById(int id) =>
      delete("$host/post/$id", headers: {"Authorization": jwtToken ?? ""});
}
