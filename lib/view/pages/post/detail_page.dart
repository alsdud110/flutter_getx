import 'package:flutter/material.dart';
import 'package:flutter_blog/controller/post_controller.dart';
import 'package:flutter_blog/controller/user_controller.dart';
import 'package:flutter_blog/view/pages/post/home_page.dart';
import 'package:flutter_blog/view/pages/post/update_page.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  final int? id; // null 이 들어올 수 있으니까
  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    UserController u = Get.find();
    PostController p = Get.find();
    // String data = Get.arguments;
    print("로그인 유저아이디 : ${u.principal.value.id}");
    return Scaffold(
      appBar: AppBar(
        title: Text("게시글 아이디 : $id, 로그인 상태 : ${u.isLogin}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${p.post.value.title}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              const Divider(),
              u.principal.value.id == p.post.value.user!.id
                  ? Row(
                      children: [
                        ElevatedButton(
                          child: const Text("삭제"),
                          onPressed: () async {
                            await p.deleteById(p.post.value.id!);
                            Get.off(() => HomePage());
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          child: const Text("수정"),
                          onPressed: () {
                            Get.to(() => UpdatePage(
                                id: p.post.value.id!,
                                title: p.post.value.title!,
                                content: p.post.value.content!));
                          },
                        ),
                      ],
                    )
                  : const SizedBox(),
              Expanded(
                  child: SingleChildScrollView(
                      child: Text("${p.post.value.content}"))),
            ],
          ),
        ),
      ),
    );
  }
}
