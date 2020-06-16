import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sneakershoottest/app/locator.dart';
import 'package:sneakershoottest/core/components.dart';
import 'package:sneakershoottest/core/models/post.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;
import 'package:stacked_services/stacked_services.dart';

class DetailPostViewModel extends StreamViewModel<Post> {
  final int id;

  DetailPostViewModel({Key key, this.id});

  String _title = '';

  String get title => _title;
  String _body = '';

  String get body => _body;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Stream<Post> get stream => _isLoading == true ? recycle() : getDetailPost();

  Stream<Post> recycle() async* {
    yield null;
    _isLoading = false;
    notifyListeners();
  }

  void refresh() {
    _isLoading = true;
    notifyListeners();
  }

  Stream<Post> getDetailPost() async* {
    yield null;
    await Future.delayed(Duration(seconds: 1));
    String url = "https://jsonplaceholder.typicode.com/posts/$id";
    var res = await http.get(url);

    if (res.statusCode == 200) {
      Post parse = Post.parsePost(res.body);
      _body = _body == '' ? parse.body : _body;
      _title = _title == '' ? parse.title : _title;
      yield parse;
    }
  }

  String getTitle() => _title;

  void setTitle(String value) {
    // update current title post
    _title = value;
  }

  void setBody(String value) {
    // update current body post
    _body = value;
  }

  handleSave(BuildContext context) async {
    // tetap update menggunakan rest api, walaupun tidak berefek pada current post
    String data = json.encode({"title": _title, "body": _body});
    await http.put(
      "https://jsonplaceholder.typicode.com/posts/$id",
      body: data,
      headers: {"Content-Type": "application/json"},
    );

    _isLoading = true;
    // memberitahukan bahwa data ada yang berubah, dan me re render widget
    notifySourceChanged();
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data == null) return LoadingComponent();
    return _buildItem(snapshot.data);
  }

  Widget _buildItem(Post post) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Text('ID: ${post.id}'),
                  title: Text(_title),
                  contentPadding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 20.0,
                  ),
                ),
                ListTile(
                  leading: Text('Body'),
                  title: Text(_body),
                  contentPadding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  showForm(BuildContext context) {
    final titleController = TextEditingController();
    titleController.value = TextEditingValue(text: _title);
    final bodyController = TextEditingController();
    bodyController.value = TextEditingValue(text: _body);

    return showDialog(
      context: context,
      barrierDismissible: false,
      child: DialogComponent(
        title: _title,
        body: _body,
        setTitle: setTitle,
        setBody: setBody,
        handleSave: handleSave,
      ),
    );
  }
}
