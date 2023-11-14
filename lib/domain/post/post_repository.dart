import 'package:flutter_blog/controller/dto/CMRespDto.dart';
import 'package:flutter_blog/controller/dto/loginReqDto.dart';
import 'package:flutter_blog/domain/post/post.dart';
import 'package:flutter_blog/domain/post/post_provider.dart';
import 'package:flutter_blog/view/pages/util/convert_utf8.dart';
import 'package:get/get_connect/http/src/response/response.dart';

// 통신을 호출해서 응답되는 데이터를 가공 => json => Dart 오브젝트
class PostRepository {
  final PostProvider _postProvider = PostProvider();

  Future<List<Post>> findAll() async {
    Response response = await _postProvider.findAll();
    dynamic body = response.body;
    CMRespDto cmRespDto = CMRespDto.fromJson(body);

    // 통신이 성공하면
    if (cmRespDto.code == 1) {
      List<dynamic> temp = cmRespDto.data;
      // 통신으로 받은 데이터를 Post Object로 바꿈
      List<Post> posts = temp.map((post) => Post.fromJson(post)).toList();
      return posts;
    } else {
      return <Post>[]; // 빈 배열을 리턴
    }
  }
}
