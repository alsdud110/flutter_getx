import 'package:flutter/material.dart';
import 'package:flutter_blog/view/pages/post/home_page.dart';
import 'package:flutter_blog/view/pages/post/update_page.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  final int id;
  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // String data = Get.arguments;
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "글 제목!!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              const Divider(),
              Row(
                children: [
                  ElevatedButton(
                    child: const Text("삭제"),
                    onPressed: () {
                      Get.off(const HomePage());
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    child: const Text("수정"),
                    onPressed: () {
                      Get.to(UpdatePage());
                    },
                  ),
                ],
              ),
              Expanded(
                  child: SingleChildScrollView(child: Text("글 내용!!" * 500))),
            ],
          ),
        ));
  }
}