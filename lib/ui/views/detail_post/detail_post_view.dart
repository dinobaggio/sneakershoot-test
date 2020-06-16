import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sneakershoottest/core/components.dart';
import 'package:sneakershoottest/core/models/post.dart';
import 'package:sneakershoottest/ui/views/detail_post/detail_post_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DetailPostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Post post = ModalRoute.of(context).settings.arguments;

    return ViewModelBuilder<DetailPostViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.red[100],
        appBar: AppBar(
          title: Text(model.title != null ? model.title : ''),
          backgroundColor: Colors.red,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(milliseconds: 500));
            model.refresh();
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: StreamBuilder<Post>(
              stream: model.stream,
              builder: model.builder,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () => model.showForm(context),
          child: IconButton(
            icon: Icon(
              Icons.mode_edit,
              color: Colors.white,
            ),
          ),
        ),
      ),
      viewModelBuilder: () => DetailPostViewModel(id: post.id),
    );
  }
}
