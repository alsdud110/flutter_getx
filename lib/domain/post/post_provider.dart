import 'package:flutter_blog/view/pages/util/jwt.dart';
import 'package:get/get.dart';

const host = "http://172.30.1.91:8080";

// 통신
class PostProvider extends GetConnect {
  Future<Response> findAll() =>
      get("$host/post", headers: {"Authorization": jwtToken ?? ""});
}
