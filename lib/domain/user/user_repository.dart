import 'package:flutter_blog/controller/dto/CMRespDto.dart';
import 'package:flutter_blog/controller/dto/joinReqDto.dart';
import 'package:flutter_blog/controller/dto/loginReqDto.dart';
import 'package:flutter_blog/domain/user/user.dart';
import 'package:flutter_blog/domain/user/user_provider.dart';
import 'package:flutter_blog/view/pages/util/jwt.dart';
import 'package:get/get_connect/http/src/response/response.dart';

// 통신을 호출해서 응답되는 데이터를 가공 => json => Dart 오브젝트
class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<User> login(String username, String password) async {
    LoginReqDto dto = LoginReqDto(username, password);
    /*
      dto.toJson() 을 하면 객체를 Map타입으로 변경

      Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
    
     */

    Response response = await _userProvider.login(dto.toJson());
    dynamic headers = response.headers;
    dynamic body = response.body;

    /*
      dynamic body = response.body 를 받으면 어떻게 되냐
      {
        code: 1,
        token: ~,
        msg: 성공/실패,
        data : {
          id: 1,
          username: ~,
          password: ,
          email: ,
          created: ,
          updated: ,
        }
      }
    
      위처럼 저장됨 body에
      그럼 Dart 객체로 변환시켜줘야함
      CMRespDto cmRespDto = CMRespDto.fromJson(body) 를 하면 Map타입을 Dart객체로 변경

      CMRespDto.fromJson(Map<String, dynamic> json)
      : code = json["code"],
        msg = json["msg"],
        data = json["data"];

      그럼 cmRespDto.code, msg, data 이런식으로 사용 가능
     */

    CMRespDto cmRespDto = CMRespDto.fromJson(body);
    if (cmRespDto.code == 1) {
      User principal = User.fromJson(cmRespDto.data);

      String token = headers["authorization"];
      jwtToken = token;

      return principal;
    } else {
      return User();
    }
  }

  Future<int> join(String username, String password, String email) async {
    JoinReqDto dto = JoinReqDto(username, password, email);
    Response response = await _userProvider.join(dto.toJson());
    dynamic body = response.body;

    CMRespDto cmRespDto = CMRespDto.fromJson(body);

    if (cmRespDto.code == 1) {
      print("회원가입완료!");
      return 1;
    } else {
      return 0;
    }
  }
}
