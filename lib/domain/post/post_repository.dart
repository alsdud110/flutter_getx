import 'package:flutter_blog/controller/dto/CMRespDto.dart';
import 'package:flutter_blog/domain/post/post.dart';
import 'package:flutter_blog/domain/post/post_provider.dart';
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

  Future<Post> findById(int id) async {
    Response response = await _postProvider.findById(id);
    dynamic body = response.body;
    CMRespDto cmRespDto = CMRespDto.fromJson(body);

    // 통신이 성공하면
    if (cmRespDto.code == 1) {
      // 상세보기 이기 때문에 그냥 하나의 객체로만 받으면 됨
      Post post = Post.fromJson(cmRespDto.data);
      return post;
    } else {
      return Post(); // 빈 배열을 리턴
    }
  }

  Future<int> deleteById(int id) async {
    Response response = await _postProvider.deleteById(id);
    dynamic body = response.body;
    CMRespDto cmRespDto = CMRespDto.fromJson(body);

    return cmRespDto.code ?? -1;
  }
}
