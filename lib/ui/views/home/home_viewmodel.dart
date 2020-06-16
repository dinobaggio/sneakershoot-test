import 'package:flutter/material.dart';
import 'package:sneakershoottest/app/locator.dart';
import 'package:sneakershoottest/core/components.dart';
import 'package:sneakershoottest/core/models/post.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sneakershoottest/app/router.gr.dart';
import 'package:http/http.dart' as http;

class HomeViewModel extends StreamViewModel<List<Post>> {
  ScrollController _scrollController = ScrollController();
  final NavigationService _navigationService = locator<NavigationService>();
  bool _isLoading = true;

  String get title => 'Daftar Post';

  List<Post> _allPost = [];
  List<Post> _currentPost = [];

  @override
  Stream<List<Post>> get stream => _isLoading == true ? recycle() : getPosts();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initialise() {
    super.initialise();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _currentPost.add(Post(title: 'tes', body: 'tex', id: 1, userId: 2));
      }
    });
  }

  Stream<List<Post>> recycle() async* {
    yield null;
    _isLoading = false;
    notifyListeners();
  }

  void refresh() {
    _isLoading = true;
    notifyListeners();
  }

  Future navigationToDetail(Post post) async {
    await _navigationService.navigateTo(Routes.detailPostView, arguments: post);
  }

  Stream<List<Post>> getPosts() async* {
    yield null;
    String url = "https://jsonplaceholder.typicode.com/posts";
    var res = await http.get(url);
    if (res.statusCode == 200) {
      var parse = Post.parsePosts(res.body);
      yield parse;
    }
  }

  builder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data == null) return LoadingComponent();

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 500));
        refresh();
      },
      child: ListPostComponent(
        navigationToDetail: navigationToDetail,
        allPost: snapshot.data,
      ),
    );
  }
}
