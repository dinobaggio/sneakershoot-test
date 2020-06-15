import 'package:flutter/material.dart';
import 'package:sneakershoottest/core/components.dart';
import 'package:sneakershoottest/core/models/post.dart';
import 'package:stacked/stacked.dart';
import 'package:sneakershoottest/ui/views/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.red[100],
        appBar: AppBar(
          title: Text("Post"),
          backgroundColor: Colors.red,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: StreamBuilder<List<Post>>(
            stream: model.stream,
            builder: (context, snapshot) => model.builder(context, snapshot),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: model.refresh,
          child: IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
