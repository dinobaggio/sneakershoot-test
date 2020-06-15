import 'dart:convert';

class Post {
  final int id;
  final int userId;
  final String body;
  final String title;

  Post({this.id, this.title, this.body, this.userId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  static List<Post> parsePosts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
  }

  static Post parsePost(String resposneBody) {
    final parse = json.decode(resposneBody);
    return Post.fromJson(parse);
  }
}
