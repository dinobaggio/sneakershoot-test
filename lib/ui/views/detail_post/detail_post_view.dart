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
      builder: (context, model, child) {
        final titleController = TextEditingController();
        titleController.value = TextEditingValue(text: model.title);
        final bodyController = TextEditingController();
        bodyController.value = TextEditingValue(text: model.body);

        return Scaffold(
          backgroundColor: Colors.red[100],
          appBar: AppBar(
            title: Text(model.title == null ? '' : model.title),
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
            onPressed: () => showDialog(
              barrierDismissible: false,
              context: context,
              child: AlertDialog(
                title: Text('Edit current post'),
                content: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(0.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            key: Key(model.title),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            onChanged: model.setTitle,
                            controller: titleController,
                            decoration: InputDecoration(labelText: "Title"),
                          ),
                          TextFormField(
                            key: Key(model.body),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            onChanged: model.setBody,
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
                    child: Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  FlatButton(
                    child: Text("Save"),
                    onPressed: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        child: AlertDialog(
                          content: LoadingComponent(),
                        ),
                      );
                      model.handleSave(context);
                    },
                  ),
                ],
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.mode_edit,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => DetailPostViewModel(id: post.id),
    );
  }
}
