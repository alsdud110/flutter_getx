import 'package:flutter/material.dart';
import 'package:flutter_blog/controller/user_controller.dart';
import 'package:flutter_blog/view/pages/post/detail_page.dart';
import 'package:flutter_blog/view/pages/post/write_page.dart';
import 'package:flutter_blog/view/pages/user/login_page.dart';
import 'package:flutter_blog/view/pages/user/user_info.dart';
import 'package:flutter_blog/size.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserController u = Get.find(); // put 없으면 만들고, 있으면 찾기

    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text("${u.isLogin}"),
      ),
      body: ListView.separated(
        itemCount: 3,
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Get.to(DetailPage(id: index + 1), arguments: "arguments 속성 테스트");
            },
            title: Text("제목 ${index + 1}"),
            leading: Text("${index + 1}"),
          );
        },
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Container(
      width: getDrawerWidth(context),
      height: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                child: const Text(
                  "글쓰기",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                onPressed: () {
                  Get.to(WritePage());
                },
              ),
              const Divider(),
              TextButton(
                child: const Text(
                  "회원정보보기",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                onPressed: () {
                  Get.to(const UserInfo());
                },
              ),
              const Divider(),
              TextButton(
                child: const Text(
                  "로그아웃",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                onPressed: () {
                  Get.to(LoginPage());
                },
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
