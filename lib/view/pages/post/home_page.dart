import 'package:flutter/material.dart';
import 'package:flutter_blog/controller/post_controller.dart';
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
    // 일단 만들어야함
    // 객체 생성(create) oninit함수 (initialize)
    // put 될 때 PostController 로 이동
    PostController p = Get.put(PostController());

    return Scaffold(
        drawer: _buildDrawer(context),
        appBar: AppBar(
          title: Text("${u.isLogin}"),
        ),
        body: Obx(
          // ListView 를 Obx(() => ListView) 이런식으로 하면 됨
          () => ListView.separated(
            itemCount: p.posts.length,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  // 클릭 할 때 PostController.findById 를 실행해서 obs Post 객체에 데이터를 넣어둔다.
                  // 그리고 DetailPage 에 가서 Controller Get.find() 하면 p.post.value.id, title 로 뿌려주면 됨
                  // 뒤에 ! 를 붙이면 절대 null 이 아니니까 걱정하지 말라는 뜻
                  p.findById(p.posts[index].id!);
                  Get.to(() => DetailPage(id: p.posts[index].id),
                      arguments: "arguments 속성 테스트");
                },
                title: Text("${p.posts[index].title}"),
                leading: Text("${p.posts[index].id}"),
              );
            },
          ),
        ));
  }

  Widget _buildDrawer(BuildContext context) {
    UserController u = Get.find(); // put 없으면 만들고, 있으면 찾기
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
                  u.logout();
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
