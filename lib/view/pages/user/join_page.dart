import 'package:flutter/material.dart';
import 'package:flutter_blog/controller/user_controller.dart';
import 'package:flutter_blog/view/components/custom_elevated_button.dart';
import 'package:flutter_blog/view/components/custom_text_form_field.dart';
import 'package:flutter_blog/view/pages/user/login_page.dart';
import 'package:flutter_blog/view/pages/util/validator_util.dart';
import 'package:get/get.dart';

class JoinPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _email = TextEditingController();

  JoinPage({super.key});

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
                "회원가입 페이지",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            _joinForm(),
          ],
        ),
      ),
    );
  }

  Widget _joinForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _username,
            hint: "Username",
            funcValidator: validateUsername(),
          ),
          CustomTextFormField(
            controller: _password,
            hint: "Password",
            funcValidator: validatePassword(),
          ),
          CustomTextFormField(
            controller: _email,
            hint: "Email",
            funcValidator: validateEmail(),
          ),
          CustomElevatedButton(
            text: "회원가입",
            funcpageRoute: () async {
              if (_formKey.currentState!.validate()) {
                int result = await UserController()
                    .join(_username.text, _password.text, _email.text);

                if (result != 1) {
                  Get.snackbar("회원가입", "회원가입 실패");
                } else {
                  Get.to(() => LoginPage());
                }
              }
            },
          ),
          TextButton(
            child: const Text("이미 회원가입이 되어 있나요?"),
            onPressed: () {
              Get.to(() => LoginPage());
            },
          ),
        ],
      ),
    );
  }
}
