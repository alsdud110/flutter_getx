import 'package:flutter_blog/controller/dto/CMRespDto.dart';
import 'package:flutter_blog/controller/dto/UpdateReqDto.dart';
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

  Future<Post> updateById(int id, String title, String content) async {
    UpdateReqDto dto = UpdateReqDto(title, content);
    Response response = await _postProvider.updateById(id, dto.toJson());

    /*
      응답 body에 상세보기 id, title, content 가 담겨있음
      그러니까 findById() 처럼 Post객체를 그대로 컨트롤러 보내주면 됨
     */

    dynamic body = response.body;
    CMRespDto cmRespDto = CMRespDto.fromJson(body);

    if (cmRespDto.code == 1) {
      Post post = Post.fromJson(cmRespDto.data);
      return post;
    } else {
      return Post();
    }
  }

  Future<Post> write(String title, String content) async {
    UpdateReqDto dto = UpdateReqDto(title, content);

    Response response = await _postProvider.write(dto.toJson());
    dynamic body = response.body;

    CMRespDto cmRespDto = CMRespDto.fromJson(body);

    if (cmRespDto.code == 1) {
      print("게시글 작성 완료");
      Post post = Post.fromJson(cmRespDto.data);
      return post;
    } else {
      print("게시글 작성 실패");
      return Post();
    }
  }
}
