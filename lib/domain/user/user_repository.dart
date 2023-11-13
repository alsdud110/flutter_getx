import 'package:flutter_blog/controller/dto/loginReqDto.dart';
import 'package:flutter_blog/domain/user/user_provider.dart';
import 'package:get/get_connect/http/src/response/response.dart';

// 통신을 호출해서 응답되는 데이터를 가공 => json => Dart 오브젝트
class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<String> login(String username, String password) async {
    LoginReqDto dto = LoginReqDto(username, password);
    Response response = await _userProvider.login(dto.toJson());
    dynamic headers = response.headers;
    if (headers["authorization"] == "Bearer null") {
      return "-1";
    } else {
      String token = headers["authorization"];
      return token;
    }
  }
}
