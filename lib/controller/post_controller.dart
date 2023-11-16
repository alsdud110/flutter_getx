import 'package:flutter_blog/domain/post/post.dart';
import 'package:flutter_blog/domain/post/post_repository.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final PostRepository _postRepository = PostRepository();
  final posts = <Post>[].obs; // 이 값이 바뀌면 UI가 바뀜
  final post = Post().obs; // 이 값이 바뀌면 UI가 바뀜

  // 컨트롤러가 put 될 때 객체 생성과 초기화가 이루어지는데
  // 처음에는 findAll() 메소드가 호출 되지 않아 obs 로 담은 posts 에 데이터가 없다.
  @override
  onInit() {
    super.onInit();
    findAll();
  }

  // 바로 List<Post> 를 리턴하면 좋겠지만 그러면 그림을 못그림
  // 그래서 obs로 관찰 가능한 리스트를 하나 만들어서
  // 그 리스트에 데이터를 담는다.
  Future<void> findAll() async {
    List<Post> posts = await _postRepository.findAll();
    this.posts.value = posts;
  }

  Future<void> findById(int id) async {
    Post post = await _postRepository.findById(id);
    this.post.value = post;
  }

  Future<void> deleteById(int id) async {
    // 삭제가 되었는지 응답 코드 수신
    int code = await _postRepository.deleteById(id);

    // 정상 삭제 완료
    if (code == 1) {
      /*
      obs 가 관찰하고 잇는 posts 리스트에서
      삭제요청을 받은 id 값과, posts 리스트에 있는 id 값이 없는 것만 골라서 다시 리스트로 만듬
      그리고, Obs가 관찰하고 있는 posts.value 에 그 리스트를 담음
     */
      List<Post> result = posts.value.where((post) => post.id != id).toList();
      posts.value = result;
    }
  }

  @override
  Future<void> updateById(int id, String title, String content) async {
    /*
      repository에서 Post객체로 받았고
      obs 가 관찰하고 있는 Post 객체에 담아주면 끝
      그리고, 홈화면의 목록에 있는 제목도 같이 변경을 해줘야하는데
      obs 가 관찰하고 있는 posts 리스트에서 Post 객체를 하나 씩 Map 에 담고
      담으면서 하나씩 조회를 해서 우리가 수정한 id에 해당하는 posts -> Post 의 id 와 같으면
      방금 새로받아온 Post 객체로 덮어씌운다~
      그리고 toList() 와 함께 obs가 관찰하고 있는 posts 리스트에 담아주면 끝
    */
    Post post = await _postRepository.updateById(id, title, content);

    if (post.id != null) {
      this.post.value = post;
      posts.value = posts.map((e) => e.id == id ? post : e).toList();
    }
  }
}
