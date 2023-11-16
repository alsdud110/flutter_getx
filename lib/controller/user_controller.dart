import 'package:flutter_blog/domain/user/user.dart';
import 'package:flutter_blog/domain/user/user_repository.dart';
import 'package:flutter_blog/view/pages/util/jwt.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepository _userRepository = UserRepository();
  final RxBool isLogin = false.obs; // UI가 관찰 가능한 변수 -> 변수가 변경이되면 UI가 자동 업데이트
  final principal = User().obs;

  void logout() {
    isLogin.value = false;
    jwtToken = null;
  }

  Future<int> login(String username, String password) async {
    User principal = await _userRepository.login(username, password);

    if (principal.id != null) {
      isLogin.value = true;
      this.principal.value = principal;
      return 1;
    } else {
      return -1;
    }
  }

  Future<int> join(String username, String password, String email) async {
    return await _userRepository.join(username, password, email);
  }
}
