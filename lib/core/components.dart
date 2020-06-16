import 'package:flutter/material.dart';

import 'models/post.dart';

class LoadingComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class DialogComponent extends StatefulWidget {
  String title;
  String body;
  var setTitle;
  var setBody;
  var handleSave;

  DialogComponent(
      {this.title, this.body, this.setTitle, this.setBody, this.handleSave});

  @override
  _DialogComponentState createState() => _DialogComponentState();
}

class _DialogComponentState extends State<DialogComponent> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    titleController.value = TextEditingValue(text: widget.title);
    final bodyController = TextEditingController();
    bodyController.value = TextEditingValue(text: widget.body);

    return AlertDialog(
      title: Text('Edit current post'),
      content: _isLoading == true
          ? LoadingComponent()
          : ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(0.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        key: Key(widget.title),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onChanged: widget.setTitle,
                        controller: titleController,
                        decoration: InputDecoration(labelText: "Title"),
                      ),
                      TextFormField(
                        key: Key(widget.body),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onChanged: widget.setBody,
                        controller: bodyController,
                        decoration: InputDecoration(labelText: "Body"),
                      ),
                    ],
                  ),
                )
              ],
            ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel", style: TextStyle(color: Colors.red)),
          onPressed:
              _isLoading == true ? null : () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text(
            "Save",
            style: TextStyle(color: Colors.green),
          ),
          onPressed: _isLoading == true
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await widget.handleSave(context);
                  Navigator.of(context).pop();
                  setState(() {
                    _isLoading = false;
                  });
                },
        ),
      ],
    );
  }
}

class ListPostComponent extends StatefulWidget {
  List<Post> allPost;
  var navigationToDetail;

  ListPostComponent({this.navigationToDetail, this.allPost});

  @override
  _ListPostComponentState createState() => _ListPostComponentState();
}

class _ListPostComponentState extends State<ListPostComponent> {
  List<Post> _currentPost = [];
  ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  List<Post> _allPost = [];
  int _limit = 10;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.allPost.forEach((element) => _allPost.add(element));
    });
    fetchPost();

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _currentIndex != _allPost.length) {
        if (_isLoading == false) {
          setState(() => _isLoading = true);
          _scrollController
              .jumpTo(_scrollController.position.maxScrollExtent + 76);
          await Future.delayed(Duration(seconds: 1));
          fetchPost();
          setState(() => _isLoading = false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _currentPost.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildItem(_currentPost[index]);
            },
          ),
        ),
        _isLoading == true
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: LoadingComponent(),
              )
            : Container()
      ],
    );
  }

  Post tes(Post post) {
    return Post();
  }

  fetchPost() {
    setState(() {
      int index = _currentIndex;
      int currentLimit = _limit;
      if (_allPost.length - _currentIndex < _limit)
        currentLimit = _currentIndex - _allPost.length;

      List<Post> tmp = new List<Post>(currentLimit).map((item) {
        Post post = _allPost[index];
        index++;
        return post;
      }).toList();

      _currentPost = [_currentPost, tmp].expand((element) => element).toList();
      _currentIndex += currentLimit;
    });
  }

  Widget _buildItem(Post post) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Text('ID: ${post.id}'),
              title: Text(post.title),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Detail'),
                  onPressed: () => widget.navigationToDetail(post),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
