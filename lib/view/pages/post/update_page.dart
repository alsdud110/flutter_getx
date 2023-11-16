import 'package:flutter/material.dart';
import 'package:flutter_blog/controller/post_controller.dart';
import 'package:flutter_blog/view/components/custom_elevated_button.dart';
import 'package:flutter_blog/view/components/custom_text_form_field.dart';
import 'package:flutter_blog/view/components/custom_textarea.dart';
import 'package:flutter_blog/view/pages/util/validator_util.dart';
import 'package:get/get.dart';

class UpdatePage extends StatelessWidget {
  final int? id;
  final String title;
  final String content;

  final _title = TextEditingController();
  final _content = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  UpdatePage({super.key, this.id, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    PostController p = Get.find();
    _title.text = title;
    _content.text = content;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                controller: _title,
                hint: "Title",
                funcValidator: validateTitle(),
              ),
              CustomTextArea(
                controller: _content,
                hint: "Content",
                funcValidator: validateContent(),
              ),
              CustomElevatedButton(
                text: "글 수정하기",
                funcpageRoute: () async {
                  if (_formKey.currentState!.validate()) {
                    await p.updateById(
                        p.post.value.id!, _title.text, _content.text);
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
