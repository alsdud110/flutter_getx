import 'package:flutter/material.dart';
import 'package:flutter_blog/controller/user_controller.dart';
import 'package:flutter_blog/view/components/custom_elevated_button.dart';
import 'package:flutter_blog/view/components/custom_text_form_field.dart';
import 'package:flutter_blog/view/pages/post/home_page.dart';
import 'package:flutter_blog/view/pages/user/join_page.dart';
import 'package:flutter_blog/view/pages/util/validator_util.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  UserController userController = Get.put(UserController());

  final _username = TextEditingController();
  final _password = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              child: const Text(
                "로그인 페이지",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            _loginForm(),
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hint: "Username",
            funcValidator: validateUsername(),
            controller: _username,
          ),
          CustomTextFormField(
            hint: "Password",
            funcValidator: validatePassword(),
            controller: _password,
          ),
          CustomElevatedButton(
            text: "로그인",
            funcpageRoute: () async {
              if (_formKey.currentState!.validate()) {
                //Get.to(const HomePage());
                int result = await userController.login(
                    _username.text.trim(), _password.text.trim());

                if (result == 1) {
                  Get.to(() => const HomePage());
                } else {
                  Get.snackbar("로그인 시도", "로그인 실패");
                }
              }
            },
          ),
          TextButton(
            child: const Text("아직 회원가입이 안되어 있나요?"),
            onPressed: () {
              Get.to(JoinPage());
            },
          ),
        ],
      ),
    );
  }
}
